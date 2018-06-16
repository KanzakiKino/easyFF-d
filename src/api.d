// Written in the D programming language.
// Copyright 2018 KanzakiKino
module easyff.api;

extern(C) @nogc nothrow
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

    struct FFMeta
    {
        const char* title;
        const char* author;
        const char* albumArtist;
        const char* album;
        const char* grouping;
        const char* composer;
        const char* year;
        const char* track;
        const char* comment;
        const char* genre;
        const char* copyright;
        const char* description;
    }

    struct FFRational
    {
        int num, den;
    }

    struct FFImage;
    void    FFImage_delete     ( FFImage** );
    FFError FFImage_checkError ( FFImage* );
    long    FFImage_getPts     ( FFImage* );
    int     FFImage_getWidth   ( FFImage* );
    int     FFImage_getHeight  ( FFImage* );
    ubyte*  FFImage_getBuffer  ( FFImage* );

    struct FFReader;
    FFReader* FFReader_new                 ( const(char)* );
    void      FFReader_delete              ( FFReader** );
    FFError   FFReader_checkError          ( FFReader* );
    FFStream* FFReader_getStream           ( FFReader*, uint );
    FFStream* FFReader_findVideoStream     ( FFReader* );
    FFStream* FFReader_findAudioStream     ( FFReader* );
    FFMeta    FFReader_getMeta             ( FFReader* );
    byte      FFReader_decode              ( FFReader*, FFStream* );
    FFImage*  FFReader_convertFrameToImage ( FFReader* );
    FFSound*  FFReader_convertFrameToSound ( FFReader* );

    struct FFSound;
    void    FFSound_delete        ( FFSound** );
    FFError FFSound_checkError    ( FFSound* );
    long    FFSound_getPts        ( FFSound* );
    int     FFSound_getSamples    ( FFSound* );
    int     FFSound_getChannels   ( FFSound* );
    int     FFSound_getSampleRate ( FFSound* );
    float*  FFSound_getBuffer     ( FFSound* );

    struct FFStream;
    FFError    FFStream_checkError    ( FFStream* );
    int        FFStream_getIndex      ( FFStream* );
    char       FFStream_isVideo       ( FFStream* );
    char       FFStream_isAudio       ( FFStream* );
    FFRational FFStream_getTimebase   ( FFStream* );
    FFRational FFStream_getAvgFPS     ( FFStream* );
    long       FFStream_getStartTime  ( FFStream* );
    long       FFStream_getDuration   ( FFStream* );
    long       FFStream_getFrameCount ( FFStream* );
}
