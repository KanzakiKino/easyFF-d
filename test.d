// Written without LICENSE in the D programming language.
// Copyright 2018 KanzakiKino
import easyff.api;
import std.string;

void main ( string[] args )
{
    if ( args.length != 2 ) {
        throw new Exception( "Args are not enough." );
    }

    auto file = FFReader_new( args[1].toStringz );
    if ( FFReader_checkError( file ) != FFError.NoError ) {
        throw new Exception( "Creating format context is failed." );
    }
    scope(exit) FFReader_delete( &file );

    auto video = FFReader_findVideoStream( file );
    if ( FFStream_checkError( video ) ) {
        throw new Exception( "Video stream is not found or invalid." );
    }

    while ( FFReader_decode( file, video ) ) {
        auto image = FFReader_convertFrameToImage( file );
        scope(exit) FFImage_delete( &image );
        // Do something to image.
    }
}
