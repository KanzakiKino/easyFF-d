// Written without LICENSE in the D programming language.
// Copyright 2018 KanzakiKino
import easyff.api;
import std.conv,
       std.stdio,
       std.string;

// Retrieves the first frame of video and save it to ./pic.png.
void main ( string[] args )
{
    if ( args.length != 2 ) {
        throw new Exception( "Args are not enough." );
    }

    auto file = FFReader_new( args[1].toStringz );
    assert( !FFReader_checkError(file) );
    scope(exit) FFReader_delete( &file );
    auto meta = FFReader_getMeta( file );
    "Author: %s".writefln( meta.author.to!string );
    "Album: %s".writefln( meta.album.to!string );

    auto video = FFReader_findVideoStream( file );
    assert( !FFStream_checkError(video) );
    auto fps = FFStream_getAvgFPS( video );
    if ( fps.den == 0 ) fps.den = 1;
    "FPS: %d".writefln( fps.num/fps.den );

    assert( FFReader_decode( file, video ) );

    auto image = FFReader_convertFrameToImage( file );
    assert( !FFImage_checkError(image) );
    scope(exit) FFImage_delete( &image );
    auto sizeX = FFImage_getWidth(image),
         sizeY = FFImage_getHeight(image);

    auto writer = FFWriter_new( "./pic.png" );
    assert( !FFWriter_checkError(writer) );
    scope(exit) FFWriter_delete( &writer );

    video = FFWriter_createVideoStream( writer );
    FFStream_setupVideoEncoder( video, sizeX, sizeY, FFRational(1,1), null);
    assert( !FFStream_checkError(video) );

    FFWriter_writeHeader( writer );
    FFWriter_encodeImage( writer, image );
    FFWriter_flush( writer );
    assert( !FFStream_checkError(video) );
}
