// Safe-Rust examples that Aeneas can translate.

/// Overflow is a panic in Rust -> becomes a `fail` in the Lean model.
pub fn incr(x: &mut u32) {
    *x += 1;
}

pub fn max(a: u32, b: u32) -> u32 {
    if a >= b { a } else { b }
}

/// Mutable borrows become functional "backward" functions.
pub fn swap_pair(p: &mut (u32, u32)) {
    let t = p.0;
    p.0 = p.1;
    p.1 = t;
}

/// Loop -> translated to a recursive function.
pub fn sum_to(n: u32) -> u32 {
    let mut i = 0;
    let mut s = 0;
    while i < n {
        i += 1;
        s += i;
    }
    s
}
