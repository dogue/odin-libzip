package ffi

import "core:c"
import "core:c/libc"
foreign import libzip "system:zip"

@(default_calling_convention = "c", link_prefix = "zip_")
foreign libzip {
    close :: proc(z: Zip) -> i32 ---
    zip_delete :: proc(z: Zip, index: u64) -> i32 ---
    dir_add :: proc(z: Zip, name: cstring, flags: FL_Flag_Set) -> i64 ---
    discard :: proc(z: Zip) ---

    error_clear :: proc(z: Zip) ---
    error_code_system :: proc(e: ^Error) -> i32 ---
    error_code_zip :: proc(e: ^Error) -> i32 ---
    error_fini :: proc(e: ^Error) ---
    error_init :: proc(e: ^Error) ---
    error_init_with_code :: proc(e: ^Error, code: Error_Code) ---
    error_set :: proc(e: ^Error, libzip_err, system_err: i32) ---
    error_set_from_source :: proc(e: ^Error, source: Source) ---
    error_strerror :: proc(e: ^Error) -> cstring ---
    error_system_type :: proc(e: ^Error) -> Error_Type ---
    error_to_data :: proc(e: ^Error, data: rawptr, len: u64) -> i64 ---
    get_error :: proc(z: Zip) -> ^Error ---

    fclose :: proc(z: Zip) -> Error_Code ---
    fdopen :: proc(fd: i32, flags: i32, errorp: ^Error) -> Zip ---
    file_add :: proc(z: Zip, name: cstring, source: Source, flags: FL_Flag_Set) -> i64 ---
    file_replace :: proc(z: Zip, index: u64, source: Source, flags: FL_Flag_Set) -> i32 ---
    file_attributes_init :: proc(attrs: ^File_Attributes) ---
    file_error_clear :: proc(z: File) ---

    file_extra_field_delete :: proc(z: Zip, index: u64, extra_field_index: u16, flags: FL_Flag_Set) -> i32 ---
    file_extra_field_delete_by_id :: proc(z: Zip, index: u64, extra_field_id, extra_field_index: u16, flags: FL_Flag_Set) -> i32 ---
    file_extra_field_get :: proc(z: Zip, index: u64, extra_field_index: u16, id, len: ^u16, flags: FL_Flag_Set) -> ^u8 ---
    file_extra_field_get_by_id :: proc(z: Zip, index: u64, extra_field_id, extra_field_index: u16, len: ^u16, flags: FL_Flag_Set) -> ^u8 ---
    file_extra_field_set :: proc(z: Zip, index: u64, extra_field_id, extra_field_index: u16, extra_field_data: ^u8, len: u16, flags: FL_Flag_Set) -> i32 ---
    file_extra_fields_count :: proc(z: Zip, index: u64, flags: FL_Flag_Set) -> i16 ---
    file_extra_fields_count_by_id :: proc(z: Zip, index: u64, extra_field_id: u16, flags: FL_Flag_Set) -> i16 ---

    file_get_comment :: proc(z: Zip, index: u64, len: ^u32, flags: FL_Flag_Set) -> cstring ---
    file_get_error :: proc(f: File) -> ^Error ---
    file_is_seekable :: proc(f: File) -> int ---
    file_rename :: proc(z: Zip, index: u64, name: cstring, flags: FL_Flag_Set) -> i32 ---
    file_set_comment :: proc(z: Zip, index: u64, comment: cstring, len: u16, flags: FL_Flag_Set) -> int ---
    file_set_dostime :: proc(z: Zip, index: u64, dostime: u16, dosdate: u16, flags: FL_Flag_Set) -> int ---
    file_set_mtime :: proc(z: Zip, index: u64, mtime: libc.time_t, flags: FL_Flag_Set) -> int ---
    file_set_encryption :: proc(z: Zip, index: u64, method: Encryption_Method, password: cstring) -> int ---

    file_get_external_attributes :: proc(z: Zip, index: u64, flags: FL_Flag_Set, os: ^Operating_System, attrs: ^u32) -> int ---
    file_set_external_attributes :: proc(z: Zip, index: u64, flags: FL_Flag_Set, os: ^Operating_System, attrs: ^u32) -> int ---

    strerror :: proc(z: Zip) -> cstring ---
    file_strerror :: proc(z: File) -> cstring ---

    fopen :: proc(z: Zip, fname: cstring, flags: FL_Flag_Set) -> File ---
    fopen_index :: proc(z: Zip, index: u64, flags: FL_Flag_Set) -> File ---
    fopen_encrypted :: proc(z: Zip, fname: cstring, flags: FL_Flag_Set, password: cstring) -> File ---
    fopen_index_encrypted :: proc(z: Zip, index: u64, flags: FL_Flag_Set, password: cstring) -> File ---

    fread :: proc(f: File, buffer: rawptr, num_bytes: u64) -> i64 ---
    fseek :: proc(f: File, offset: i64, whence: i32) -> i8 ---
    ftell :: proc(f: File) -> i64 ---

    get_archive_comment :: proc(z: Zip, len: ^int, flags: FL_Flag_Set) -> cstring ---
    get_archive_flag :: proc(z: Zip, flag: FL_Flag, flags: FL_Flag_Set) -> int ---

}
