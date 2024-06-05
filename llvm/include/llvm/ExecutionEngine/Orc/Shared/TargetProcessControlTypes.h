//===--- TargetProcessControlTypes.h -- Shared Core/TPC types ---*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// TargetProcessControl types that are used by both the Orc and
// OrcTargetProcess libraries.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_EXECUTIONENGINE_ORC_SHARED_TARGETPROCESSCONTROLTYPES_H
#define LLVM_EXECUTIONENGINE_ORC_SHARED_TARGETPROCESSCONTROLTYPES_H

#include "llvm/ADT/ArrayRef.h"
#include "llvm/ADT/StringRef.h"
#include "llvm/ExecutionEngine/JITSymbol.h"
#include "llvm/ExecutionEngine/Orc/Shared/AllocationActions.h"
#include "llvm/ExecutionEngine/Orc/Shared/ExecutorAddress.h"
#include "llvm/ExecutionEngine/Orc/Shared/MemoryFlags.h"
#include "llvm/ExecutionEngine/Orc/Shared/SimplePackedSerialization.h"
#include "llvm/ExecutionEngine/Orc/Shared/WrapperFunctionUtils.h"
#include "llvm/Support/Memory.h"

#include <vector>

namespace llvm {
namespace orc {
namespace tpctypes {

struct SegFinalizeRequest {
  AllocGroup AG;
  ExecutorAddr Addr;
  uint64_t Size;
  ArrayRef<char> Content;
};

struct FinalizeRequest {
  std::vector<SegFinalizeRequest> Segments;
  shared::AllocActions Actions;
};

struct SharedMemorySegFinalizeRequest {
  AllocGroup AG;
  ExecutorAddr Addr;
  uint64_t Size;
};

struct SharedMemoryFinalizeRequest {
  std::vector<SharedMemorySegFinalizeRequest> Segments;
  shared::AllocActions Actions;
};

template <typename T> struct UIntWrite {
  UIntWrite() = default;
  UIntWrite(ExecutorAddr Addr, T Value) : Addr(Addr), Value(Value) {}

  ExecutorAddr Addr;
  T Value = 0;
};

/// Describes a write to a uint8_t.
using UInt8Write = UIntWrite<uint8_t>;

/// Describes a write to a uint16_t.
using UInt16Write = UIntWrite<uint16_t>;

/// Describes a write to a uint32_t.
using UInt32Write = UIntWrite<uint32_t>;

/// Describes a write to a uint64_t.
using UInt64Write = UIntWrite<uint64_t>;

/// Describes a write to a buffer.
/// For use with TargetProcessControl::MemoryAccess objects.
struct BufferWrite {
  BufferWrite() = default;
  BufferWrite(ExecutorAddr Addr, StringRef Buffer)
      : Addr(Addr), Buffer(Buffer) {}

  ExecutorAddr Addr;
  StringRef Buffer;
};

/// A handle used to represent a loaded dylib in the target process.
using DylibHandle = JITTargetAddress;

using LookupResult = std::vector<JITTargetAddress>;

} // end namespace tpctypes

namespace shared {

class SPSAllocGroup {};

using SPSSegFinalizeRequest =
    SPSTuple<SPSAllocGroup, SPSExecutorAddr, uint64_t, SPSSequence<char>>;

using SPSFinalizeRequest = SPSTuple<SPSSequence<SPSSegFinalizeRequest>,
                                    SPSSequence<SPSAllocActionCallPair>>;

using SPSSharedMemorySegFinalizeRequest =
    SPSTuple<SPSAllocGroup, SPSExecutorAddr, uint64_t>;

using SPSSharedMemoryFinalizeRequest =
    SPSTuple<SPSSequence<SPSSharedMemorySegFinalizeRequest>,
             SPSSequence<SPSAllocActionCallPair>>;

template <typename T>
using SPSMemoryAccessUIntWrite = SPSTuple<SPSExecutorAddr, T>;

using SPSMemoryAccessUInt8Write = SPSMemoryAccessUIntWrite<uint8_t>;
using SPSMemoryAccessUInt16Write = SPSMemoryAccessUIntWrite<uint16_t>;
using SPSMemoryAccessUInt32Write = SPSMemoryAccessUIntWrite<uint32_t>;
using SPSMemoryAccessUInt64Write = SPSMemoryAccessUIntWrite<uint64_t>;

using SPSMemoryAccessBufferWrite = SPSTuple<SPSExecutorAddr, SPSSequence<char>>;

template <> class SPSSerializationTraits<SPSAllocGroup, AllocGroup> {
  enum WireBits {
    ReadBit = 1 << 0,
    WriteBit = 1 << 1,
    ExecBit = 1 << 2,
    FinalizeBit = 1 << 3
  };

public:
  static size_t size(const AllocGroup &AG) {
    // All AllocGroup values encode to the same size.
    return SPSArgList<uint8_t>::size(uint8_t(0));
  }

  static bool serialize(SPSOutputBuffer &OB, const AllocGroup &AG) {
    uint8_t WireValue = 0;
    if ((AG.getMemProt() & MemProt::Read) != MemProt::None)
      WireValue |= ReadBit;
    if ((AG.getMemProt() & MemProt::Write) != MemProt::None)
      WireValue |= WriteBit;
    if ((AG.getMemProt() & MemProt::Exec) != MemProt::None)
      WireValue |= ExecBit;
    if (AG.getMemDeallocPolicy() == MemDeallocPolicy::Finalize)
      WireValue |= FinalizeBit;
    return SPSArgList<uint8_t>::serialize(OB, WireValue);
  }

  static bool deserialize(SPSInputBuffer &IB, AllocGroup &AG) {
    uint8_t Val;
    if (!SPSArgList<uint8_t>::deserialize(IB, Val))
      return false;
    MemProt MP = MemProt::None;
    if (Val & ReadBit)
      MP |= MemProt::Read;
    if (Val & WriteBit)
      MP |= MemProt::Write;
    if (Val & ExecBit)
      MP |= MemProt::Exec;
    MemDeallocPolicy MDP = (Val & FinalizeBit) ? MemDeallocPolicy::Finalize
                                               : MemDeallocPolicy::Standard;
    AG = AllocGroup(MP, MDP);
    return true;
  }
};

template <>
class SPSSerializationTraits<SPSSegFinalizeRequest,
                             tpctypes::SegFinalizeRequest> {
  using SFRAL = SPSSegFinalizeRequest::AsArgList;

public:
  static size_t size(const tpctypes::SegFinalizeRequest &SFR) {
    return SFRAL::size(SFR.AG, SFR.Addr, SFR.Size, SFR.Content);
  }

  static bool serialize(SPSOutputBuffer &OB,
                        const tpctypes::SegFinalizeRequest &SFR) {
    return SFRAL::serialize(OB, SFR.AG, SFR.Addr, SFR.Size, SFR.Content);
  }

  static bool deserialize(SPSInputBuffer &IB,
                          tpctypes::SegFinalizeRequest &SFR) {
    return SFRAL::deserialize(IB, SFR.AG, SFR.Addr, SFR.Size, SFR.Content);
  }
};

template <>
class SPSSerializationTraits<SPSFinalizeRequest, tpctypes::FinalizeRequest> {
  using FRAL = SPSFinalizeRequest::AsArgList;

public:
  static size_t size(const tpctypes::FinalizeRequest &FR) {
    return FRAL::size(FR.Segments, FR.Actions);
  }

  static bool serialize(SPSOutputBuffer &OB,
                        const tpctypes::FinalizeRequest &FR) {
    return FRAL::serialize(OB, FR.Segments, FR.Actions);
  }

  static bool deserialize(SPSInputBuffer &IB, tpctypes::FinalizeRequest &FR) {
    return FRAL::deserialize(IB, FR.Segments, FR.Actions);
  }
};

template <>
class SPSSerializationTraits<SPSSharedMemorySegFinalizeRequest,
                             tpctypes::SharedMemorySegFinalizeRequest> {
  using SFRAL = SPSSharedMemorySegFinalizeRequest::AsArgList;

public:
  static size_t size(const tpctypes::SharedMemorySegFinalizeRequest &SFR) {
    return SFRAL::size(SFR.AG, SFR.Addr, SFR.Size);
  }

  static bool serialize(SPSOutputBuffer &OB,
                        const tpctypes::SharedMemorySegFinalizeRequest &SFR) {
    return SFRAL::serialize(OB, SFR.AG, SFR.Addr, SFR.Size);
  }

  static bool deserialize(SPSInputBuffer &IB,
                          tpctypes::SharedMemorySegFinalizeRequest &SFR) {
    return SFRAL::deserialize(IB, SFR.AG, SFR.Addr, SFR.Size);
  }
};

template <>
class SPSSerializationTraits<SPSSharedMemoryFinalizeRequest,
                             tpctypes::SharedMemoryFinalizeRequest> {
  using FRAL = SPSSharedMemoryFinalizeRequest::AsArgList;

public:
  static size_t size(const tpctypes::SharedMemoryFinalizeRequest &FR) {
    return FRAL::size(FR.Segments, FR.Actions);
  }

  static bool serialize(SPSOutputBuffer &OB,
                        const tpctypes::SharedMemoryFinalizeRequest &FR) {
    return FRAL::serialize(OB, FR.Segments, FR.Actions);
  }

  static bool deserialize(SPSInputBuffer &IB,
                          tpctypes::SharedMemoryFinalizeRequest &FR) {
    return FRAL::deserialize(IB, FR.Segments, FR.Actions);
  }
};

template <typename T>
class SPSSerializationTraits<SPSMemoryAccessUIntWrite<T>,
                             tpctypes::UIntWrite<T>> {
public:
  static size_t size(const tpctypes::UIntWrite<T> &W) {
    return SPSTuple<SPSExecutorAddr, T>::AsArgList::size(W.Addr, W.Value);
  }

  static bool serialize(SPSOutputBuffer &OB, const tpctypes::UIntWrite<T> &W) {
    return SPSTuple<SPSExecutorAddr, T>::AsArgList::serialize(OB, W.Addr,
                                                              W.Value);
  }

  static bool deserialize(SPSInputBuffer &IB, tpctypes::UIntWrite<T> &W) {
    return SPSTuple<SPSExecutorAddr, T>::AsArgList::deserialize(IB, W.Addr,
                                                                W.Value);
  }
};

template <>
class SPSSerializationTraits<SPSMemoryAccessBufferWrite,
                             tpctypes::BufferWrite> {
public:
  static size_t size(const tpctypes::BufferWrite &W) {
    return SPSTuple<SPSExecutorAddr, SPSSequence<char>>::AsArgList::size(
        W.Addr, W.Buffer);
  }

  static bool serialize(SPSOutputBuffer &OB, const tpctypes::BufferWrite &W) {
    return SPSTuple<SPSExecutorAddr, SPSSequence<char>>::AsArgList ::serialize(
        OB, W.Addr, W.Buffer);
  }

  static bool deserialize(SPSInputBuffer &IB, tpctypes::BufferWrite &W) {
    return SPSTuple<SPSExecutorAddr,
                    SPSSequence<char>>::AsArgList ::deserialize(IB, W.Addr,
                                                                W.Buffer);
  }
};

} // end namespace shared
} // end namespace orc
} // end namespace llvm

#endif // LLVM_EXECUTIONENGINE_ORC_SHARED_TARGETPROCESSCONTROLTYPES_H
