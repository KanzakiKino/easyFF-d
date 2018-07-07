// Written in the D programming language.
// Copyright 2018 KanzakiKino
module easyff.ver;
import easyff.api;

enum EASYFF_VERSION_MAJOR = 1;
enum EASYFF_VERSION_MINOR = 0;
enum EASYFF_VERSION_MICRO = 2;

static this ()
{
    auto status =
        (EASYFF_VERSION_MAJOR == FF_getMajorVersion()) &&
        (EASYFF_VERSION_MINOR == FF_getMinorVersion());
    if ( !status ) {
        throw new Error( "Incompatible libeasyff version." );
    }
    if ( !FF_hasVersionIntegrity() ) {
        throw new Error( "libeasyff has no version integrity." );
    }

    version ( SafeMode ) if ( EASYFF_VERSION_MICRO != FF_getMicroVersion() ) {
        import std.stdio;
        "easyFF-d: The minor version of libeasyff is not supported.".writeln;
    }
}
