/**
 * A D implementation of the C stdatomic.h header.
 *
 * $(NOTE If it compiles it should produce similar assembly to the system C toolchain
 *   and should not introduce when optimizing unnecessary behaviors,
 *   if you do not care about this guarantee use the _impl suffix.)
 *
 * $(NOTE The D shared type qualifier is the closest to the _Atomic type qualifier from C. It may be changed from shared in the future.)
 *
 * Copyright: Copyright Richard (Rikki) Andrew Cattermole 2023.
 * License:   $(LINK2 http://www.boost.org/LICENSE_1_0.txt, Boost License 1.0)
 * Authors:   Richard (Rikki) Andrew cattermole
 * Source:    $(DRUNTIMESRC core/stdc/stdatomic.d)
 */
module core.stdc.stdatomic;
import core.atomic : MemoryOrder;
import core.internal.atomic;
import core.stdc.config;
import core.stdc.stdint;

@safe nothrow @nogc:

///
enum memory_order
{
    /// No ordering provided
    memory_order_relaxed = MemoryOrder.raw,
    /// As per cppreference.com circa 2015 no compiler supports consume memory order and in practice it devolves to acquire.
    memory_order_consume = MemoryOrder.acq,
    /// Prevent reordering before operation
    memory_order_acquire = MemoryOrder.acq,
    /// Prevent reordering after operation
    memory_order_release = MemoryOrder.rel,
    /// Prevent reordering before and after operation
    memory_order_acq_rel = MemoryOrder.acq_rel,
    /// Prevent reordering before for read operations and after for writes.
    memory_order_seq_cst = MemoryOrder.seq
}

///
enum
{
    ///
    __STDC_VERSION_STDATOMIC_H__ = 202311,

    ///
    ATOMIC_BOOL_LOCK_FREE = IsAtomicLockFree!bool ? 2 : 0,
    ///
    ATOMIC_CHAR_LOCK_FREE = IsAtomicLockFree!char ? 2 : 0,
    ///
    ATOMIC_CHAR16_T_LOCK_FREE = IsAtomicLockFree!wchar ? 2 : 0,
    ///
    ATOMIC_CHAR32_T_LOCK_FREE = IsAtomicLockFree!dchar ? 2 : 0,
    ///
    ATOMIC_WCHAR_T_LOCK_FREE = ATOMIC_CHAR16_T_LOCK_FREE,
    ///
    ATOMIC_SHORT_LOCK_FREE = IsAtomicLockFree!short ? 2 : 0,
    ///
    ATOMIC_INT_LOCK_FREE = IsAtomicLockFree!int ? 2 : 0,
    ///
    ATOMIC_LONG_LOCK_FREE = IsAtomicLockFree!c_long ? 2 : 0,
    ///
    ATOMIC_LLONG_LOCK_FREE = IsAtomicLockFree!ulong ? 2 : 0,
    ///
    ATOMIC_POINTER_LOCK_FREE = IsAtomicLockFree!(void*) ? 2 : 0,
    ///
    ATOMIC_CHAR8_T_LOCK_FREE = ATOMIC_CHAR_LOCK_FREE,
}

version (DigitalMars)
{
    alias atomic_signal_fence = atomic_signal_fence_impl; ///

    // these all use inline assembly, so will unlikely produce the codegen a user will expect
    version(none)
    {
        alias atomic_flag_clear = atomic_flag_clear_impl; ///
        alias atomic_flag_clear_explicit = atomic_flag_clear_explicit_impl; ///
        alias atomic_flag_test_and_set = atomic_flag_test_and_set_impl; ///
        alias atomic_flag_test_and_set_explicit = atomic_flag_test_and_set_explicit_impl; ///
        alias atomic_thread_fence = atomic_thread_fence_impl; ///
        alias atomic_store = atomic_store_impl; ///
        alias atomic_store_explicit = atomic_store_explicit_impl; ///
        alias atomic_load = atomic_load_impl; ///
        alias atomic_load_explicit = atomic_load_explicit_impl; ///
        alias atomic_exchange = atomic_exchange_impl; ///
        alias atomic_exchange_explicit = atomic_exchange_explicit_impl; ///
        alias atomic_compare_exchange_strong = atomic_compare_exchange_strong_impl; ///
        alias atomic_compare_exchange_weak = atomic_compare_exchange_weak_impl; ///
        alias atomic_compare_exchange_strong_explicit = atomic_compare_exchange_strong_explicit_impl; ///
        alias atomic_compare_exchange_weak_explicit = atomic_compare_exchange_weak_explicit_impl; ///
        alias atomic_fetch_add = atomic_fetch_add_impl; ///
        alias atomic_fetch_add_explicit = atomic_fetch_add_explicit_impl; ///
        alias atomic_fetch_sub = atomic_fetch_sub_impl; ///
        alias atomic_fetch_sub_explicit = atomic_fetch_sub_explicit_impl; ///
        alias atomic_fetch_or = atomic_fetch_or_impl; ///
        alias atomic_fetch_or_explicit = atomic_fetch_or_explicit_impl; ///
        alias atomic_fetch_xor = atomic_fetch_xor_impl; ///
        alias atomic_fetch_xor_explicit = atomic_fetch_xor_explicit_impl; ///
        alias atomic_fetch_and = atomic_fetch_and_impl; ///
        alias atomic_fetch_and_explicit = atomic_fetch_and_explicit_impl; ///
    }
}
else version(GNU)
{
    alias atomic_flag_clear = atomic_flag_clear_impl; ///
    alias atomic_flag_clear_explicit = atomic_flag_clear_explicit_impl; ///
    alias atomic_flag_test_and_set = atomic_flag_test_and_set_impl; ///
    alias atomic_flag_test_and_set_explicit = atomic_flag_test_and_set_explicit_impl; ///
    alias atomic_signal_fence = atomic_signal_fence_impl; ///
    alias atomic_thread_fence = atomic_thread_fence_impl; ///
    alias atomic_store = atomic_store_impl; ///
    alias atomic_store_explicit = atomic_store_explicit_impl; ///
    alias atomic_load = atomic_load_impl; ///
    alias atomic_load_explicit = atomic_load_explicit_impl; ///
    alias atomic_exchange = atomic_exchange_impl; ///
    alias atomic_exchange_explicit = atomic_exchange_explicit_impl; ///
    alias atomic_compare_exchange_strong = atomic_compare_exchange_strong_impl; ///
    alias atomic_compare_exchange_weak = atomic_compare_exchange_weak_impl; ///
    alias atomic_compare_exchange_strong_explicit = atomic_compare_exchange_strong_explicit_impl; ///
    alias atomic_compare_exchange_weak_explicit = atomic_compare_exchange_weak_explicit_impl; ///
    alias atomic_fetch_add = atomic_fetch_add_impl; ///
    alias atomic_fetch_add_explicit = atomic_fetch_add_explicit_impl; ///
    alias atomic_fetch_sub = atomic_fetch_sub_impl; ///
    alias atomic_fetch_sub_explicit = atomic_fetch_sub_explicit_impl; ///
    alias atomic_fetch_or = atomic_fetch_or_impl; ///
    alias atomic_fetch_or_explicit = atomic_fetch_or_explicit_impl; ///
    alias atomic_fetch_xor = atomic_fetch_xor_impl; ///
    alias atomic_fetch_xor_explicit = atomic_fetch_xor_explicit_impl; ///
    alias atomic_fetch_and = atomic_fetch_and_impl; ///
    alias atomic_fetch_and_explicit = atomic_fetch_and_explicit_impl; ///
}

///
pragma(inline, true)
bool atomic_is_lock_free(A)(const shared(A)* obj)
{
    return IsAtomicLockFree!A;
}

/// Guaranteed to be a atomic boolean type
struct atomic_flag
{
    private bool b;
}

///
enum ATOMIC_FLAG_INIT = atomic_flag.init;

///
pragma(inline, true)
void atomic_flag_clear_impl()(atomic_flag* obj)
{
    assert(obj !is null);

    atomicStore(&obj.b, false);
}

///
pragma(inline, true)
void atomic_flag_clear_explicit_impl()(atomic_flag* obj, memory_order order)
{
    assert(obj !is null);

    final switch (order)
    {
        case memory_order.memory_order_relaxed:
            atomicStore!(memory_order.memory_order_relaxed)(&obj.b, false);
            break;

        case memory_order.memory_order_acquire:
            // What GCC does here is generate a relaxed order (no barriers)
            // we'll copy it, although the D compiler should really be helping out at compile time.
            atomicStore!(memory_order.memory_order_relaxed)(&obj.b, false);
            break;

        case memory_order.memory_order_release:
            atomicStore!(memory_order.memory_order_release)(&obj.b, false);
            break;

        case memory_order.memory_order_acq_rel:
            atomicStore!(memory_order.memory_order_acq_rel)(&obj.b, false);
            break;

        case memory_order.memory_order_seq_cst:
            atomicStore(&obj.b, false);
            break;
    }
}

///
pragma(inline, true)
bool atomic_flag_test_and_set_impl()(atomic_flag* obj)
{
    assert(obj !is null);
    return atomicExchange(&obj.b, true);
}

///
unittest
{
    atomic_flag flag;
    assert(!atomic_flag_test_and_set_impl(&flag));
    atomic_flag_clear_impl(&flag);
}

///
pragma(inline, true)
bool atomic_flag_test_and_set_explicit_impl()(atomic_flag* obj, memory_order order)
{
    assert(obj !is null);

    final switch (order)
    {
        case memory_order.memory_order_relaxed:
            return atomicExchange!(memory_order.memory_order_relaxed)(&obj.b, true);

        case memory_order.memory_order_acquire:
            return atomicExchange!(memory_order.memory_order_acquire)(&obj.b, true);

        case memory_order.memory_order_release:
            return atomicExchange!(memory_order.memory_order_release)(&obj.b, true);

        case memory_order.memory_order_acq_rel:
            return atomicExchange!(memory_order.memory_order_acq_rel)(&obj.b, true);

        case memory_order.memory_order_seq_cst:
            return atomicExchange(&obj.b, true);
    }
}

///
unittest
{
    atomic_flag flag;
    assert(!atomic_flag_test_and_set_explicit_impl(&flag, memory_order.memory_order_seq_cst));
    atomic_flag_clear_explicit_impl(&flag, memory_order.memory_order_seq_cst);
}

/**
 * Initializes an atomic variable, the destination should not have any expression associated with it prior to this call.
 *
 * We use an out parameter instead of a pointer for destination in an attempt to communicate to the compiler that it initializers.
 */
pragma(inline, true)
void atomic_init(A, C)(out shared(A) obj, C desired) @trusted
{
    obj = cast(shared) desired;
}

///
unittest
{
    shared int val;
    atomic_init(val, 2);
}

/// No-op function, doesn't apply to D
pragma(inline, true)
A kill_dependency(A)(A y) @trusted
{
    return y;
}

/// Don't allow reordering, does not emit any instructions.
pragma(inline, true)
void atomic_signal_fence_impl()(memory_order order)
{
    final switch (order)
    {
        case memory_order.memory_order_relaxed:
            atomicSignalFence!(memory_order.memory_order_relaxed);
            break;

        case memory_order.memory_order_acquire:
            atomicSignalFence!(memory_order.memory_order_acquire);
            break;

        case memory_order.memory_order_release:
            atomicSignalFence!(memory_order.memory_order_release);
            break;

        case memory_order.memory_order_acq_rel:
            atomicSignalFence!(memory_order.memory_order_acq_rel);
            break;

        case memory_order.memory_order_seq_cst:
            atomicSignalFence!(memory_order.memory_order_seq_cst);
            break;
    }
}

///
unittest
{
    atomic_signal_fence_impl(memory_order.memory_order_seq_cst);
}

/// Don't allow reordering, and emit a fence instruction.
pragma(inline, true)
void atomic_thread_fence_impl()(memory_order order)
{
    final switch (order)
    {
        case memory_order.memory_order_relaxed:
            atomicFence!(memory_order.memory_order_relaxed);
            break;

        case memory_order.memory_order_acquire:
            atomicFence!(memory_order.memory_order_acquire);
            break;

        case memory_order.memory_order_release:
            atomicFence!(memory_order.memory_order_release);
            break;

        case memory_order.memory_order_acq_rel:
            atomicFence!(memory_order.memory_order_acq_rel);
            break;

        case memory_order.memory_order_seq_cst:
            atomicFence!(memory_order.memory_order_seq_cst);
            break;
    }
}

///
unittest
{
    atomic_thread_fence_impl(memory_order.memory_order_seq_cst);
}

///
alias atomic_bool = shared(bool);
///
alias atomic_char = shared(char);
///
alias atomic_schar = shared(byte);
///
alias atomic_uchar = shared(ubyte);
///
alias atomic_short = shared(short);
///
alias atomic_ushort = shared(ushort);
///
alias atomic_int = shared(int);
///
alias atomic_uint = shared(uint);
///
alias atomic_long = shared(c_long);
///
alias atomic_ulong = shared(c_ulong);
///
alias atomic_llong = shared(long);
///
alias atomic_ullong = shared(ulong);
///
alias atomic_char8_t = shared(char);
///
alias atomic_char16_t = shared(wchar);
///
alias atomic_char32_t = shared(dchar);
///
alias atomic_wchar_t = shared(wchar);

///
alias atomic_int_least8_t = shared(int_least8_t);
///
alias atomic_uint_least8_t = shared(uint_least8_t);
///
alias atomic_int_least16_t = shared(int_least16_t);
///
alias atomic_uint_least16_t = shared(uint_least16_t);
///
alias atomic_int_least32_t = shared(int_least32_t);
///
alias atomic_uint_least32_t = shared(uint_least32_t);
///
alias atomic_int_least64_t = shared(int_least64_t);
///
alias atomic_uint_least64_t = shared(uint_least64_t);
///
alias atomic_int_fast8_t = shared(int_fast8_t);
///
alias atomic_uint_fast8_t = shared(uint_fast8_t);
///
alias atomic_int_fast16_t = shared(int_fast16_t);
///
alias atomic_uint_fast16_t = shared(uint_fast16_t);
///
alias atomic_int_fast32_t = shared(int_fast32_t);
///
alias atomic_uint_fast32_t = shared(uint_fast32_t);
///
alias atomic_int_fast64_t = shared(int_fast64_t);
///
alias atomic_uint_fast64_t = shared(uint_fast64_t);
///
alias atomic_intptr_t = shared(intptr_t);
///
alias atomic_uintptr_t = shared(uintptr_t);
///
alias atomic_size_t = shared(size_t);
///
alias atomic_ptrdiff_t = shared(ptrdiff_t);
///
alias atomic_intmax_t = shared(intmax_t);
///
alias atomic_uintmax_t = shared(uintmax_t);

///
pragma(inline, true)
void atomic_store_impl(A, C)(shared(A)* obj, C desired) @trusted
{
    assert(obj !is null);
    atomicStore(obj, cast(A)desired);
}

///
unittest
{
    shared(int) obj;
    atomic_store_impl(&obj, 3);
}

///
pragma(inline, true)
void atomic_store_explicit_impl(A, C)(shared(A)* obj, C desired, memory_order order) @trusted
{
    assert(obj !is null);

    final switch (order)
    {
        case memory_order.memory_order_relaxed:
            atomicStore!(memory_order.memory_order_relaxed)(obj, cast(A)desired);
            break;

        case memory_order.memory_order_acquire:
            // What GCC does here is generate a relaxed order (no barriers)
            // we'll copy it, although the D compiler should really be helping out at compile time.
            atomicStore!(memory_order.memory_order_relaxed)(obj, cast(A)desired);
            break;

        case memory_order.memory_order_release:
            atomicStore!(memory_order.memory_order_release)(obj, cast(A)desired);
            break;

        case memory_order.memory_order_acq_rel:
            atomicStore!(memory_order.memory_order_acq_rel)(obj, cast(A)desired);
            break;

        case memory_order.memory_order_seq_cst:
            atomicStore!(memory_order.memory_order_seq_cst)(obj, cast(A)desired);
            break;
    }
}

///
unittest
{
    shared(int) obj;
    atomic_store_explicit_impl(&obj, 3, memory_order.memory_order_seq_cst);
}

///
pragma(inline, true)
A atomic_load_impl(A)(const shared(A)* obj) @trusted
{
    assert(obj !is null);
    return atomicLoad(cast(shared(A)*)obj);
}

///
unittest
{
    shared(int) obj = 3;
    assert(atomic_load_impl(&obj) == 3);
}

///
pragma(inline, true)
A atomic_load_explicit_impl(A)(const shared(A)* obj, memory_order order) @trusted
{
    assert(obj !is null);

    final switch (order)
    {
        case memory_order.memory_order_relaxed:
            return atomicLoad!(memory_order.memory_order_relaxed)(obj);

        case memory_order.memory_order_acquire:
            return atomicLoad!(memory_order.memory_order_acquire)(obj);

        case memory_order.memory_order_release:
            // What GCC does here is generate a relaxed order (no barriers)
            // we'll copy it, although the D compiler should really be helping out at compile time.
            return atomicLoad!(memory_order.memory_order_relaxed)(obj);

        case memory_order.memory_order_acq_rel:
            return atomicLoad!(memory_order.memory_order_acq_rel)(obj);

        case memory_order.memory_order_seq_cst:
            return atomicLoad!(memory_order.memory_order_seq_cst)(obj);
    }
}

///
unittest
{
    shared(int) obj = 3;
    assert(atomic_load_explicit_impl(&obj, memory_order.memory_order_seq_cst) == 3);
}

///
pragma(inline, true)
A atomic_exchange_impl(A, C)(const shared(A)* obj, C desired) @trusted
{
    assert(obj !is null);
    return atomicExchange(cast(shared(A)*)obj, cast(A)desired);
}

///
unittest
{
    shared(int) obj = 3;
    assert(atomic_exchange_impl(&obj, 2) == 3);
}

///
pragma(inline, true)
A atomic_exchange_explicit_impl(A, C)(const shared(A)* obj, C desired, memory_order order) @trusted
{
    assert(obj !is null);

    final switch (order)
    {
        case memory_order.memory_order_relaxed:
            return atomicExchange!(memory_order.memory_order_relaxed)(obj, cast(A)desired);

        case memory_order.memory_order_acquire:
            return atomicExchange!(memory_order.memory_order_acquire)(obj, cast(A)desired);

        case memory_order.memory_order_release:
            return atomicExchange!(memory_order.memory_order_release)(obj, cast(A)desired);

        case memory_order.memory_order_acq_rel:
            return atomicExchange!(memory_order.memory_order_acq_rel)(obj, cast(A)desired);

        case memory_order.memory_order_seq_cst:
            return atomicExchange!(memory_order.memory_order_seq_cst)(obj, cast(A)desired);
    }
}

///
unittest
{
    shared(int) obj = 3;
    assert(atomic_exchange_explicit_impl(&obj, 2, memory_order.memory_order_seq_cst) == 3);
}

///
pragma(inline, true)
bool atomic_compare_exchange_strong_impl(A, C)(shared(A)* obj, A* expected, C desired) @trusted
{
    return atomicCompareExchangeStrong(cast(A*)obj, expected, cast(A)desired);
}

///
unittest
{
    shared(int) obj = 3;
    int expected = 3;
    assert(atomic_compare_exchange_strong_impl(&obj, &expected, 2));
}

///
pragma(inline, true)
bool atomic_compare_exchange_weak_impl(A, C)(shared(A)* obj, A* expected, C desired) @trusted
{
    return atomicCompareExchangeStrong(cast(A*)obj, expected, cast(A)desired);
}

///
unittest
{
    shared(int) obj = 3;
    int expected = 3;
    static assert(__traits(compiles, {atomic_compare_exchange_weak_impl(&obj, &expected, 2);}));
}

///
pragma(inline, true)
bool atomic_compare_exchange_strong_explicit_impl(A, C)(shared(A)* obj, A* expected, C desired, memory_order succ, memory_order fail) @trusted
{
    assert(obj !is null);
    // We use these giant switch inside switch statements
    //  because as of 2023 they are capable of being for the most part inlined by gdc & ldc when using literal arguments for memory_order.

    final switch(succ)
    {
        case memory_order.memory_order_relaxed:
            final switch(fail)
            {
                case memory_order.memory_order_relaxed:
                    return atomicCompareExchangeStrong!(memory_order.memory_order_relaxed, memory_order.memory_order_relaxed)(cast(A*)obj, expected, cast(A)desired);
                case memory_order.memory_order_acquire:
                    return atomicCompareExchangeStrong!(memory_order.memory_order_relaxed, memory_order.memory_order_acquire)(cast(A*)obj, expected, cast(A)desired);
                case memory_order.memory_order_release:
                    return atomicCompareExchangeStrong!(memory_order.memory_order_relaxed, memory_order.memory_order_release)(cast(A*)obj, expected, cast(A)desired);
                case memory_order.memory_order_acq_rel:
                    return atomicCompareExchangeStrong!(memory_order.memory_order_relaxed, memory_order.memory_order_acq_rel)(cast(A*)obj, expected, cast(A)desired);
                case memory_order.memory_order_seq_cst:
                    return atomicCompareExchangeStrong!(memory_order.memory_order_relaxed, memory_order.memory_order_seq_cst)(cast(A*)obj, expected, cast(A)desired);
            }
        case memory_order.memory_order_acquire:
            final switch(fail)
            {
                case memory_order.memory_order_relaxed:
                    return atomicCompareExchangeStrong!(memory_order.memory_order_acquire, memory_order.memory_order_relaxed)(cast(A*)obj, expected, cast(A)desired);
                case memory_order.memory_order_acquire:
                    return atomicCompareExchangeStrong!(memory_order.memory_order_acquire, memory_order.memory_order_acquire)(cast(A*)obj, expected, cast(A)desired);
                case memory_order.memory_order_release:
                    return atomicCompareExchangeStrong!(memory_order.memory_order_acquire, memory_order.memory_order_release)(cast(A*)obj, expected, cast(A)desired);
                case memory_order.memory_order_acq_rel:
                    return atomicCompareExchangeStrong!(memory_order.memory_order_acquire, memory_order.memory_order_acq_rel)(cast(A*)obj, expected, cast(A)desired);
                case memory_order.memory_order_seq_cst:
                    return atomicCompareExchangeStrong!(memory_order.memory_order_acquire, memory_order.memory_order_seq_cst)(cast(A*)obj, expected, cast(A)desired);
            }
        case memory_order.memory_order_release:
            final switch(fail)
            {
                case memory_order.memory_order_relaxed:
                    return atomicCompareExchangeStrong!(memory_order.memory_order_release, memory_order.memory_order_relaxed)(cast(A*)obj, expected, cast(A)desired);
                case memory_order.memory_order_acquire:
                    return atomicCompareExchangeStrong!(memory_order.memory_order_release, memory_order.memory_order_acquire)(cast(A*)obj, expected, cast(A)desired);
                case memory_order.memory_order_release:
                    return atomicCompareExchangeStrong!(memory_order.memory_order_release, memory_order.memory_order_release)(cast(A*)obj, expected, cast(A)desired);
                case memory_order.memory_order_acq_rel:
                    return atomicCompareExchangeStrong!(memory_order.memory_order_release, memory_order.memory_order_acq_rel)(cast(A*)obj, expected, cast(A)desired);
                case memory_order.memory_order_seq_cst:
                    return atomicCompareExchangeStrong!(memory_order.memory_order_release, memory_order.memory_order_seq_cst)(cast(A*)obj, expected, cast(A)desired);
            }
        case memory_order.memory_order_acq_rel:
            final switch(fail)
            {
                case memory_order.memory_order_relaxed:
                    return atomicCompareExchangeStrong!(memory_order.memory_order_acq_rel, memory_order.memory_order_relaxed)(cast(A*)obj, expected, cast(A)desired);
                case memory_order.memory_order_acquire:
                    return atomicCompareExchangeStrong!(memory_order.memory_order_acq_rel, memory_order.memory_order_acquire)(cast(A*)obj, expected, cast(A)desired);
                case memory_order.memory_order_release:
                    return atomicCompareExchangeStrong!(memory_order.memory_order_acq_rel, memory_order.memory_order_release)(cast(A*)obj, expected, cast(A)desired);
                case memory_order.memory_order_acq_rel:
                    return atomicCompareExchangeStrong!(memory_order.memory_order_acq_rel, memory_order.memory_order_acq_rel)(cast(A*)obj, expected, cast(A)desired);
                case memory_order.memory_order_seq_cst:
                    return atomicCompareExchangeStrong!(memory_order.memory_order_acq_rel, memory_order.memory_order_seq_cst)(cast(A*)obj, expected, cast(A)desired);
            }
        case memory_order.memory_order_seq_cst:
            final switch(fail)
            {
                case memory_order.memory_order_relaxed:
                    return atomicCompareExchangeStrong!(memory_order.memory_order_seq_cst, memory_order.memory_order_relaxed)(cast(A*)obj, expected, cast(A)desired);
                case memory_order.memory_order_acquire:
                    return atomicCompareExchangeStrong!(memory_order.memory_order_seq_cst, memory_order.memory_order_acquire)(cast(A*)obj, expected, cast(A)desired);
                case memory_order.memory_order_release:
                    return atomicCompareExchangeStrong!(memory_order.memory_order_seq_cst, memory_order.memory_order_release)(cast(A*)obj, expected, cast(A)desired);
                case memory_order.memory_order_acq_rel:
                    return atomicCompareExchangeStrong!(memory_order.memory_order_seq_cst, memory_order.memory_order_acq_rel)(cast(A*)obj, expected, cast(A)desired);
                case memory_order.memory_order_seq_cst:
                    return atomicCompareExchangeStrong!(memory_order.memory_order_seq_cst, memory_order.memory_order_seq_cst)(cast(A*)obj, expected, cast(A)desired);
            }
    }
}

///
unittest
{
    shared(int) obj = 3;
    int expected = 3;
    assert(atomic_compare_exchange_strong_explicit_impl(&obj, &expected, 2, memory_order.memory_order_seq_cst, memory_order.memory_order_seq_cst));
}

///
pragma(inline, true)
bool atomic_compare_exchange_weak_explicit_impl(A, C)(shared(A)* obj, A* expected, C desired, memory_order succ, memory_order fail) @trusted
{
    assert(obj !is null);
    // We use these giant switch inside switch statements
    //  because as of 2023 they are capable of being for the most part inlined by gdc & ldc when using literal arguments for memory_order.

    final switch(succ)
    {
        case memory_order.memory_order_relaxed:
            final switch(fail)
            {
                case memory_order.memory_order_relaxed:
                    return atomicCompareExchangeWeak!(memory_order.memory_order_relaxed, memory_order.memory_order_relaxed)(cast(A*)obj, expected, cast(A)desired);
                case memory_order.memory_order_acquire:
                    return atomicCompareExchangeWeak!(memory_order.memory_order_relaxed, memory_order.memory_order_relaxed)(cast(A*)obj, expected, cast(A)desired);
                case memory_order.memory_order_release:
                    return atomicCompareExchangeWeak!(memory_order.memory_order_relaxed, memory_order.memory_order_relaxed)(cast(A*)obj, expected, cast(A)desired);
                case memory_order.memory_order_acq_rel:
                    return atomicCompareExchangeWeak!(memory_order.memory_order_relaxed, memory_order.memory_order_relaxed)(cast(A*)obj, expected, cast(A)desired);
                case memory_order.memory_order_seq_cst:
                    return atomicCompareExchangeWeak!(memory_order.memory_order_relaxed, memory_order.memory_order_relaxed)(cast(A*)obj, expected, cast(A)desired);
            }
        case memory_order.memory_order_acquire:
            final switch(fail)
            {
                case memory_order.memory_order_relaxed:
                    return atomicCompareExchangeWeak!(memory_order.memory_order_acquire, memory_order.memory_order_relaxed)(cast(A*)obj, expected, cast(A)desired);
                case memory_order.memory_order_acquire:
                    return atomicCompareExchangeWeak!(memory_order.memory_order_acquire, memory_order.memory_order_acquire)(cast(A*)obj, expected, cast(A)desired);
                case memory_order.memory_order_release:
                    return atomicCompareExchangeWeak!(memory_order.memory_order_acquire, memory_order.memory_order_release)(cast(A*)obj, expected, cast(A)desired);
                case memory_order.memory_order_acq_rel:
                    return atomicCompareExchangeWeak!(memory_order.memory_order_acquire, memory_order.memory_order_acq_rel)(cast(A*)obj, expected, cast(A)desired);
                case memory_order.memory_order_seq_cst:
                    return atomicCompareExchangeWeak!(memory_order.memory_order_acquire, memory_order.memory_order_seq_cst)(cast(A*)obj, expected, cast(A)desired);
            }
        case memory_order.memory_order_release:
            final switch(fail)
            {
                case memory_order.memory_order_relaxed:
                    return atomicCompareExchangeWeak!(memory_order.memory_order_release, memory_order.memory_order_relaxed)(cast(A*)obj, expected, cast(A)desired);
                case memory_order.memory_order_acquire:
                    return atomicCompareExchangeWeak!(memory_order.memory_order_release, memory_order.memory_order_acquire)(cast(A*)obj, expected, cast(A)desired);
                case memory_order.memory_order_release:
                    return atomicCompareExchangeWeak!(memory_order.memory_order_release, memory_order.memory_order_release)(cast(A*)obj, expected, cast(A)desired);
                case memory_order.memory_order_acq_rel:
                    return atomicCompareExchangeWeak!(memory_order.memory_order_release, memory_order.memory_order_acq_rel)(cast(A*)obj, expected, cast(A)desired);
                case memory_order.memory_order_seq_cst:
                    return atomicCompareExchangeWeak!(memory_order.memory_order_release, memory_order.memory_order_seq_cst)(cast(A*)obj, expected, cast(A)desired);
            }
        case memory_order.memory_order_acq_rel:
            final switch(fail)
            {
                case memory_order.memory_order_relaxed:
                    return atomicCompareExchangeWeak!(memory_order.memory_order_acq_rel, memory_order.memory_order_relaxed)(cast(A*)obj, expected, cast(A)desired);
                case memory_order.memory_order_acquire:
                    return atomicCompareExchangeWeak!(memory_order.memory_order_acq_rel, memory_order.memory_order_acquire)(cast(A*)obj, expected, cast(A)desired);
                case memory_order.memory_order_release:
                    return atomicCompareExchangeWeak!(memory_order.memory_order_acq_rel, memory_order.memory_order_release)(cast(A*)obj, expected, cast(A)desired);
                case memory_order.memory_order_acq_rel:
                    return atomicCompareExchangeWeak!(memory_order.memory_order_acq_rel, memory_order.memory_order_acq_rel)(cast(A*)obj, expected, cast(A)desired);
                case memory_order.memory_order_seq_cst:
                    return atomicCompareExchangeWeak!(memory_order.memory_order_acq_rel, memory_order.memory_order_seq_cst)(cast(A*)obj, expected, cast(A)desired);
            }
        case memory_order.memory_order_seq_cst:
            final switch(fail)
            {
                case memory_order.memory_order_relaxed:
                    return atomicCompareExchangeWeak!(memory_order.memory_order_seq_cst, memory_order.memory_order_relaxed)(cast(A*)obj, expected, cast(A)desired);
                case memory_order.memory_order_acquire:
                    return atomicCompareExchangeWeak!(memory_order.memory_order_seq_cst, memory_order.memory_order_acquire)(cast(A*)obj, expected, cast(A)desired);
                case memory_order.memory_order_release:
                    return atomicCompareExchangeWeak!(memory_order.memory_order_seq_cst, memory_order.memory_order_release)(cast(A*)obj, expected, cast(A)desired);
                case memory_order.memory_order_acq_rel:
                    return atomicCompareExchangeWeak!(memory_order.memory_order_seq_cst, memory_order.memory_order_acq_rel)(cast(A*)obj, expected, cast(A)desired);
                case memory_order.memory_order_seq_cst:
                    return atomicCompareExchangeWeak!(memory_order.memory_order_seq_cst, memory_order.memory_order_seq_cst)(cast(A*)obj, expected, cast(A)desired);
            }
    }
}

///
unittest
{
    shared(int) obj = 3;
    int expected = 3;
    atomic_compare_exchange_weak_explicit_impl(&obj, &expected, 2, memory_order.memory_order_seq_cst, memory_order.memory_order_seq_cst);
}

///
pragma(inline, true)
A atomic_fetch_add_impl(A, M)(shared(A)* obj, M arg) @trusted
{
    assert(obj !is null);
    return atomicFetchAdd(cast(A*)obj, arg);
}

///
unittest
{
    shared(int) val;
    atomic_fetch_add_impl(&val, 3);
    assert(atomic_load_impl(&val) == 3);
}

pragma(inline, true)
A atomic_fetch_sub_impl(A, M)(shared(A)* obj, M arg) @trusted
{
    assert(obj !is null);
    return atomicFetchSub(cast(A*)obj, arg);
}

///
unittest
{
    shared(int) val = 3;
    atomic_fetch_sub_impl(&val, 3);
    assert(atomic_load_impl(&val) == 0);
}

///
pragma(inline, true)
A atomic_fetch_add_explicit_impl(A, M)(shared(A)* obj, M arg, memory_order order) @trusted
{
    assert(obj !is null);

    final switch(order)
    {
        case memory_order.memory_order_relaxed:
            return atomicFetchAdd!(memory_order.memory_order_relaxed)(cast(A*)obj, arg);
        case memory_order.memory_order_acquire:
            return atomicFetchAdd!(memory_order.memory_order_acquire)(cast(A*)obj, arg);
        case memory_order.memory_order_release:
            return atomicFetchAdd!(memory_order.memory_order_release)(cast(A*)obj, arg);
        case memory_order.memory_order_acq_rel:
            return atomicFetchAdd!(memory_order.memory_order_acq_rel)(cast(A*)obj, arg);
        case memory_order.memory_order_seq_cst:
            return atomicFetchAdd!(memory_order.memory_order_seq_cst)(cast(A*)obj, arg);
    }
}

///
unittest
{
    shared(int) val;
    atomic_fetch_add_explicit_impl(&val, 3, memory_order.memory_order_seq_cst);
    assert(atomic_load_impl(&val) == 3);
}

///
pragma(inline, true)
A atomic_fetch_sub_explicit_impl(A, M)(shared(A)* obj, M arg, memory_order order) @trusted
{
    assert(obj !is null);

    final switch(order)
    {
        case memory_order.memory_order_relaxed:
            return atomicFetchSub!(memory_order.memory_order_relaxed)(cast(A*)obj, arg);
        case memory_order.memory_order_acquire:
            return atomicFetchSub!(memory_order.memory_order_acquire)(cast(A*)obj, arg);
        case memory_order.memory_order_release:
            return atomicFetchSub!(memory_order.memory_order_release)(cast(A*)obj, arg);
        case memory_order.memory_order_acq_rel:
            return atomicFetchSub!(memory_order.memory_order_acq_rel)(cast(A*)obj, arg);
        case memory_order.memory_order_seq_cst:
            return atomicFetchSub!(memory_order.memory_order_seq_cst)(cast(A*)obj, arg);
    }
}

///
unittest
{
    shared(int) val = 3;
    atomic_fetch_sub_explicit_impl(&val, 3, memory_order.memory_order_seq_cst);
    assert(atomic_load_impl(&val) == 0);
}

///
pragma(inline, true)
A atomic_fetch_or_impl(A, M)(shared(A)* obj, M arg) @trusted
{
    assert(obj !is null);

    // copied from atomicOp

    A set, get = atomicLoad(cast(A*)obj);

    do
    {
        set = get | arg;
    } while (!atomicCompareExchangeWeak!(memory_order.memory_order_seq_cst, memory_order.memory_order_seq_cst)(cast(A*)obj, &get, cast(A)set));

    return get;
}

///
unittest
{
    shared(int) val = 5;
    atomic_fetch_or_impl(&val, 3);
    assert(atomic_load_impl(&val) == 7);
}

///
pragma(inline, true)
A atomic_fetch_or_explicit_impl(A, M)(shared(A)* obj, M arg, memory_order order) @trusted
{
    assert(obj !is null);

    A set, get;

    final switch(order)
    {
        case memory_order.memory_order_relaxed:
            get = atomicLoad!(memory_order.memory_order_relaxed)(cast(A*)obj);
            do
            {
                set = get | arg;
            } while (!atomicCompareExchangeWeak!(memory_order.memory_order_relaxed, memory_order.memory_order_relaxed)(cast(A*)obj, &get, cast(A)set));
            break;

        case memory_order.memory_order_acquire:
            get = atomicLoad!(memory_order.memory_order_acquire)(cast(A*)obj);
            do
            {
                set = get | arg;
            } while (!atomicCompareExchangeWeak!(memory_order.memory_order_acquire, memory_order.memory_order_acquire)(cast(A*)obj, &get, cast(A)set));
            break;

        case memory_order.memory_order_release:
            get = atomicLoad!(memory_order.memory_order_relaxed)(cast(A*)obj);
            do
            {
                set = get | arg;
            } while (!atomicCompareExchangeWeak!(memory_order.memory_order_release, memory_order.memory_order_release)(cast(A*)obj, &get, cast(A)set));
            break;

        case memory_order.memory_order_acq_rel:
            get = atomicLoad!(memory_order.memory_order_acq_rel)(cast(A*)obj);
            do
            {
                set = get | arg;
            } while (!atomicCompareExchangeWeak!(memory_order.memory_order_acq_rel, memory_order.memory_order_acq_rel)(cast(A*)obj, &get, cast(A)set));
            break;

        case memory_order.memory_order_seq_cst:
            get = atomicLoad!(memory_order.memory_order_relaxed)(cast(A*)obj);
            do
            {
                set = get | arg;
            } while (!atomicCompareExchangeWeak!(memory_order.memory_order_seq_cst, memory_order.memory_order_seq_cst)(cast(A*)obj, &get, cast(A)set));
            break;
    }

    return get;
}

///
unittest
{
    shared(int) val = 5;
    atomic_fetch_or_explicit_impl(&val, 3, memory_order.memory_order_seq_cst);
    assert(atomic_load_impl(&val) == 7);
}

///
pragma(inline, true)
A atomic_fetch_xor_impl(A, M)(shared(A)* obj, M arg) @trusted
{
    assert(obj !is null);

    // copied from atomicOp

    A set, get = atomicLoad(cast(A*)obj);

    do
    {
        set = get ^ arg;
    } while (!atomicCompareExchangeWeak!(memory_order.memory_order_seq_cst, memory_order.memory_order_seq_cst)(cast(A*)obj, &get, cast(A)set));

    return get;
}

///
unittest
{
    shared(int) val = 5;
    atomic_fetch_xor_impl(&val, 3);
    assert(atomic_load_impl(&val) == 6);
}

///
pragma(inline, true)
A atomic_fetch_xor_explicit_impl(A, M)(shared(A)* obj, M arg, memory_order order) @trusted
{
    assert(obj !is null);

    A set, get;

    final switch(order)
    {
        case memory_order.memory_order_relaxed:
            get = atomicLoad!(memory_order.memory_order_relaxed)(cast(A*)obj);
            do
            {
                set = get ^ arg;
            } while (!atomicCompareExchangeWeak!(memory_order.memory_order_relaxed, memory_order.memory_order_relaxed)(cast(A*)obj, &get, cast(A)set));
            break;

        case memory_order.memory_order_acquire:
            get = atomicLoad!(memory_order.memory_order_acquire)(cast(A*)obj);
            do
            {
                set = get ^ arg;
            } while (!atomicCompareExchangeWeak!(memory_order.memory_order_acquire, memory_order.memory_order_acquire)(cast(A*)obj, &get, cast(A)set));
            break;

        case memory_order.memory_order_release:
            get = atomicLoad!(memory_order.memory_order_relaxed)(cast(A*)obj);
            do
            {
                set = get ^ arg;
            } while (!atomicCompareExchangeWeak!(memory_order.memory_order_release, memory_order.memory_order_release)(cast(A*)obj, &get, cast(A)set));
            break;

        case memory_order.memory_order_acq_rel:
            get = atomicLoad!(memory_order.memory_order_acq_rel)(cast(A*)obj);
            do
            {
                set = get ^ arg;
            } while (!atomicCompareExchangeWeak!(memory_order.memory_order_acq_rel, memory_order.memory_order_acq_rel)(cast(A*)obj, &get, cast(A)set));
            break;

        case memory_order.memory_order_seq_cst:
            get = atomicLoad!(memory_order.memory_order_relaxed)(cast(A*)obj);
            do
            {
                set = get ^ arg;
            } while (!atomicCompareExchangeWeak!(memory_order.memory_order_seq_cst, memory_order.memory_order_seq_cst)(cast(A*)obj, &get, cast(A)set));
            break;
    }

    return get;
}

///
unittest
{
    shared(int) val = 5;
    atomic_fetch_xor_explicit_impl(&val, 3, memory_order.memory_order_seq_cst);
    assert(atomic_load_impl(&val) == 6);
}

///
pragma(inline, true)
A atomic_fetch_and_impl(A, M)(shared(A)* obj, M arg) @trusted
{
    assert(obj !is null);

    // copied from atomicOp

    A set, get = atomicLoad(cast(A*)obj);

    do
    {
        set = get & arg;
    } while (!atomicCompareExchangeWeak!(memory_order.memory_order_seq_cst, memory_order.memory_order_seq_cst)(cast(A*)obj, &get, cast(A)set));

    return get;
}

///
unittest
{
    shared(int) val = 5;
    atomic_fetch_and_impl(&val, 3);
    assert(atomic_load_impl(&val) == 1);
}

///
pragma(inline, true)
A atomic_fetch_and_explicit_impl(A, M)(shared(A)* obj, M arg, memory_order order) @trusted
{
    assert(obj !is null);

    A set, get;

    final switch(order)
    {
        case memory_order.memory_order_relaxed:
            get = atomicLoad!(memory_order.memory_order_relaxed)(cast(A*)obj);
            do
            {
                set = get & arg;
            } while (!atomicCompareExchangeWeak!(memory_order.memory_order_relaxed, memory_order.memory_order_relaxed)(cast(A*)obj, &get, cast(A)set));
            break;

        case memory_order.memory_order_acquire:
            get = atomicLoad!(memory_order.memory_order_acquire)(cast(A*)obj);
            do
            {
                set = get & arg;
            } while (!atomicCompareExchangeWeak!(memory_order.memory_order_acquire, memory_order.memory_order_acquire)(cast(A*)obj, &get, cast(A)set));
            break;

        case memory_order.memory_order_release:
            get = atomicLoad!(memory_order.memory_order_relaxed)(cast(A*)obj);
            do
            {
                set = get & arg;
            } while (!atomicCompareExchangeWeak!(memory_order.memory_order_release, memory_order.memory_order_release)(cast(A*)obj, &get, cast(A)set));
            break;

        case memory_order.memory_order_acq_rel:
            get = atomicLoad!(memory_order.memory_order_acq_rel)(cast(A*)obj);
            do
            {
                set = get & arg;
            } while (!atomicCompareExchangeWeak!(memory_order.memory_order_acq_rel, memory_order.memory_order_acq_rel)(cast(A*)obj, &get, cast(A)set));
            break;

        case memory_order.memory_order_seq_cst:
            get = atomicLoad!(memory_order.memory_order_relaxed)(cast(A*)obj);
            do
            {
                set = get & arg;
            } while (!atomicCompareExchangeWeak!(memory_order.memory_order_seq_cst, memory_order.memory_order_seq_cst)(cast(A*)obj, &get, cast(A)set));
            break;
    }

    return get;
}

///
unittest
{
    shared(int) val = 5;
    atomic_fetch_and_explicit_impl(&val, 3, memory_order.memory_order_seq_cst);
    assert(atomic_load_impl(&val) == 1);
}
