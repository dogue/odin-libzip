package ffi

import "core:c"
import "core:c/libc"

foreign import libzip "system:zip"

@(default_calling_convention = "c")
foreign libzip {}

// flags for zip_open
Open_Flag_Set:: distinct bit_set[Open_Flag]
Open_Flag :: enum uint {
    CREATE    = 0,
    EXCL      = 1,
    CHECKCONS = 2,
    TRUNCATE  = 3,
    RDONLY    = 4,
}

// flags for zip_name_locate, zip_fopen, zip_stat, etc
FL_ENC_GUESS :: FL_Flag_Set{}
FL_Flag_Set :: distinct bit_set[FL_Flag]
FL_Flag :: enum uint {
    NOCASE     = 0,
    NODIR      = 1,
    COMPRESSED = 2,
    UNCHANGED  = 3,
    ENCRYPTED  = 5,
    ENC_RAW    = 6,
    ENC_STRICT = 7,
    LOCAL      = 8,
    CENTRAL    = 9,
    ENC_UTF_8  = 11,
    ENC_CP437  = 12,
    OVERWRITE  = 13,
}

// archive global flags
AFL_Flag_Set :: distinct bit_set[AFL_Flag]
AFL_Flag :: enum uint {
    RDONLY                                = 1,
    IS_TORRENTZIP                         = 2,
    WANT_TORRENTZIP                       = 3,
    CREATE_OR_KEEP_FILE_FOR_EMPTY_ARCHIVE = 4,
}

EXTRA_FIELD_ALL :: max(u16)
EXTRA_FIELD_NEW :: max(u16)

LENGTH_TO_END :: 0
LENGTH_UNCHECKED :: -2

Error :: struct {
    zip_err: i32,
    sys_err: i32,
    str: cstring,
}

Error_Code :: enum int {
    OK              = 0,
    MULTIDISK       = 1,
    RENAME          = 2,
    CLOSE           = 3,
    SEEK            = 4,
    READ            = 5,
    WRITE           = 6,
    CRC             = 7,
    ZIPCLOSED       = 8,
    NOENT           = 9,
    EXISTS          = 10,
    OPEN            = 11,
    TMPOPEN         = 12,
    ZLIB            = 13,
    MEMORY          = 14,
    CHANGED         = 15,
    COMPNOTSUPP     = 16,
    EOF             = 17,
    INVAL           = 18,
    NOZIP           = 19,
    INTERNAL        = 20,
    INCONS          = 21,
    REMOVE          = 22,
    DELETED         = 23,
    ENCRNOSUPP      = 24,
    RDONLY          = 25,
    NOPASSWD        = 26,
    WRONGPASSWD     = 27,
    OPNOTSUPP       = 28,
    INUSE           = 29,
    TELL            = 30,
    COMPRESSED_DATA = 31,
    CANCELLED       = 32,
    DATA_LENGTH     = 33,
    NOT_ALLOWED     = 34,
    TRUNCATED_ZIP   = 35,
}

Error_Type :: enum i32 {
    NONE   = 0,
    SYS    = 1,
    ZLIB   = 2,
    LIBZIP = 3,
}

Compression_Method :: enum int {
    DEFAULT        = -1,
    STORE          = 0,
    SHRINK         = 1,
    REDUCE_1       = 2,
    REDUCE_2       = 3,
    REDUCE_3       = 4,
    REDUCE_4       = 5,
    IMPLODE        = 6,
    DEFLATE        = 8,
    DEFLATE64      = 9,
    PKWARE_IMPLODE = 10,
    BZIP2          = 12,
    LZMA           = 14,
    TERSE          = 18,
    LZ77           = 19,
    LZMA2          = 33,
    ZSTD           = 93,
    XZ             = 95,
    JPEG           = 96,
    WAVPACK        = 97,
    PPM            = 98,
}

Encryption_Method :: enum u16 {
    NONE          = 0x0000,
    TRAD_PKWARE   = 0x0001,
    AES_128       = 0x0101,
    AES_192       = 0x0102,
    AES_256       = 0x0103,
    DES           = 0x6601,
    RC2_OLD       = 0x6602,
    _3DES_168     = 0x6603,
    _3DES_112     = 0x6609,
    PKZIP_AES_128 = 0x660e,
    PKZIP_AES_192 = 0x660f,
    PKZIP_AES_256 = 0x6610,
    RC2           = 0x6702,
    RC4           = 0x6801,
    UNKNOWN       = 0xffff,
}

OPSYS_DEFAULT :: Operating_System.UNIX
Operating_System :: enum uint {
    DOS           = 0x00,
    AMIGA         = 0x01,
    OPENVMS       = 0x02,
    UNIX          = 0x03,
    VM_CMS        = 0x04,
    ATARI_ST      = 0x05,
    OS_2          = 0x06,
    MACINTOSH     = 0x07,
    Z_SYSTEM      = 0x08,
    CPM           = 0x09,
    WINDOWS_NTFS  = 0x0a,
    MVS           = 0x0b,
    VSE           = 0x0c,
    ACORD_RISC    = 0x0d,
    VFAT          = 0x0e,
    ALTERNATE_MVS = 0x0f,
    BEOS          = 0x10,
    TANDEM        = 0x11,
    OS_400        = 0x12,
    OS_X          = 0x13,
}

Source_Command_Bitmask :: distinct bit_set[Source_Command]
Source_Command :: enum int {
   OPEN                = 0,
   READ                = 1,
   CLOSE               = 2,
   STAT                = 3,
   ERROR               = 4,
   FREE                = 5,
   SEEK                = 6,
   TELL                = 7,
   BEGIN_WRITE         = 8,
   COMMIT_WRITE        = 9,
   ROLLBACK_WRITE      = 10,
   WRITE               = 11,
   SEEK_WRITE          = 12,
   TELL_WRITE          = 13,
   SUPPORTS            = 14,
   REMOVE              = 15,
   RESERVED_1          = 16,
   BEGIN_WRITE_CLONING = 17,
   ACCEPT_EMPTY        = 18,
   GET_FILE_ATTRIBUTES = 19,
   SUPPORTS_REOPEN     = 20,
   GET_DOS_TIME        = 21,
}

SOURCE_SUPPORTS_READABLE :: Source_Command_Bitmask {
    .OPEN,
    .READ,
    .CLOSE,
    .STAT,
    .ERROR,
    .FREE,
}

SOURCE_SUPPORTS_SEEKABLE :: Source_Command_Bitmask {
    .SEEK,
    .TELL,
    .SUPPORTS
} | SOURCE_SUPPORTS_READABLE

SOURCE_SUPPORTS_WRITABLE :: Source_Command_Bitmask {
    .BEGIN_WRITE,
    .COMMIT_WRITE,
    .ROLLBACK_WRITE,
    .WRITE,
    .SEEK_WRITE,
    .TELL_WRITE,
    .REMOVE
} | SOURCE_SUPPORTS_SEEKABLE

Source_Args_Seek :: struct {
    offset: i64,
    whence: i32,
}

Stat_Valid_Fields :: distinct bit_set[Stat_Field]
Stat_Field :: enum uint {
    NAME              = 0,
    INDEX             = 1,
    SIZE              = 2,
    COMP_SIZE         = 3,
    MTIME             = 4,
    CRC               = 5,
    COMP_METHOD       = 6,
    ENCRYPTION_METHOD = 7,
    FLAGS             = 8,
}

Stat :: struct {
    valid: Stat_Valid_Fields,
    name: cstring,
    index: u64,
    size: u64,
    comp_size: u64,
    mtime: libc.time_t,
    crc: u32,
    comp_method: u16,
    encryption_method: u16,
    flags: u32,
}

Buffer_Fragment :: struct {
    data: [^]u8,
    length: u64,
}

File_Attributes_Valid_Fields :: distinct bit_set[File_Attributes_Field]
File_Attributes_Field :: enum uint {
    FILE_ATTRIBUTES_HOST_SYSTEM               = 0,
    FILE_ATTRIBUTES_ASCII                     = 1,
    FILE_ATTRIBUTES_VERSION_NEEDED            = 2,
    FILE_ATTRIBUTES_EXTERNAL_FILE_ATTRIBUTES  = 3,
    FILE_ATTRIBUTES_GENERAL_PURPOSE_BIT_FLAGS = 4,
}

File_Attributes :: struct {
    valid: File_Attributes_Valid_Fields,
    version: u8,
    host_system: u8,
    ascii: u8,
    version_needed: u8,
    external_file_attributes: u32,
    general_purpose_bit_flags: u16,
    general_purpose_bit_mask: u16,
}

Zip :: distinct rawptr
File :: distinct rawptr
Source :: distinct rawptr
