// Written without LICENSE in the D programming language.
// Copyright 2018 KanzakiKino
import easyff.api;
import std.conv,
       std.stdio,
       std.string;

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
    auto meta = FFReader_getMeta( file );
    "Author: %s".writefln( meta.author.to!string );
    "Album: %s".writefln( meta.album.to!string );

    auto video = FFReader_findVideoStream( file );
    if ( FFStream_checkError( video ) ) {
        throw new Exception( "Video stream is not found or invalid." );
    }
    auto fps = FFStream_getAvgFPS( video );
    if ( fps.den == 0 ) fps.den = 1;
    "FPS: %d".writefln( fps.num/fps.den );

    while ( FFReader_decode( file, video ) ) {
        auto image = FFReader_convertFrameToImage( file );
        scope(exit) FFImage_delete( &image );
        // Do something to image.
    }
}
