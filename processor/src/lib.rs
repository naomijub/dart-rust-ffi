use std::os::raw::c_int;

#[no_mangle]
#[allow(non_snake_case)]
pub unsafe extern "C" fn vecSumEven(vec: *const c_int, size: i32) -> c_int {
    if vec.is_null() {
        return 0;
    }

    let v =  std::slice::from_raw_parts(vec, size as usize);
    v.iter().filter(|x| *x % &2 == 0).sum::<i32>() as c_int
}
