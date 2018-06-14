// Written in the D programming language.
// Copyright 2018 KanzakiKino
module easyff.api;

extern(C) @nogc
{
    enum FFError : ubyte
    {
        NoError       = 0x00,
        NullPointer   = 0x01,
        IllegalObject = 0x02,
        CreateContext = 0x03,
        Stream        = 0x04,
        NoCodec       = 0x05,
        PacketLost    = 0x06,
        InvalidFrame  = 0x07,
    }

    struct FFImage;
    void    FFImage_delete     ( FFImage** );
    FFError FFImage_checkError ( FFImage* );
    int     FFImage_getWidth   ( FFImage* );
    int     FFImage_getHeight  ( FFImage* );
    ubyte*  FFImage_getBuffer  ( FFImage* );

    struct FFReader;
    FFReader* FFReader_new                 ( const(char)* );
    void      FFReader_delete              ( FFReader** );
    FFError   FFReader_checkError          ( FFReader* );
    FFStream* FFReader_findVideoStream     ( FFReader* );
    FFStream* FFReader_findAudioStream     ( FFReader* );
    byte      FFReader_decode              ( FFReader*, FFStream* );
    FFImage*  FFReader_convertFrameToImage ( FFReader* );

    struct FFStream;
    FFError FFStream_checkError ( FFStream* );
    int     FFStream_getIndex   ( FFStream* );
    char    FFStream_isVideo    ( FFStream* );
    char    FFStream_isAudio    ( FFStream* );
}
