// Written in the D programming language.
// Copyright 2018 KanzakiKino
module easyff.api;

extern(C) @nogc nothrow
{
    enum FFError : ubyte
    {
        NoError       = 0x00,
        NullPointer,
        IllegalObject,
        CreateContext,
        InvalidContext,
        Stream,
        NoCodec,
        PacketLost,
        InvalidFrame,
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
    FFImage* FFImage_new        ( int, int, long );
    void     FFImage_delete     ( FFImage** );
    FFError  FFImage_checkError ( FFImage* );
    long     FFImage_getPts     ( FFImage* );
    void     FFImage_setPts     ( FFImage*, long );
    int      FFImage_getWidth   ( FFImage* );
    int      FFImage_getHeight  ( FFImage* );
    ubyte*   FFImage_getBuffer  ( FFImage* );

    struct FFOption;
    FFOption* FFOption_new    ();
    void      FFOption_delete ( FFOption** );
    FFError   FFOption_set    ( FFOption*, const(char)*, const(char)* );

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
    FFSound*  FFReader_convertFrameToSound ( FFReader*, int, int );
    FFError   FFReader_seek                ( FFReader*, FFStream*, long );

    struct FFSound;
    FFSound* FFSound_new           ( int, int, int, long );
    void     FFSound_delete        ( FFSound** );
    FFError  FFSound_checkError    ( FFSound* );
    long     FFSound_getPts        ( FFSound* );
    void     FFSound_setPts        ( FFSound*, long );
    int      FFSound_getSamples    ( FFSound* );
    int      FFSound_getChannels   ( FFSound* );
    int      FFSound_getSampleRate ( FFSound* );
    float*   FFSound_getBuffer     ( FFSound* );

    struct FFStream;
    FFError    FFStream_checkError        ( FFStream* );
    int        FFStream_getIndex          ( FFStream* );
    char       FFStream_isWritable        ( FFStream* );
    char       FFStream_isVideo           ( FFStream* );
    char       FFStream_isAudio           ( FFStream* );
    FFRational FFStream_getTimebase       ( FFStream* );
    FFRational FFStream_getAvgFPS         ( FFStream* );
    long       FFStream_getStartTime      ( FFStream* );
    long       FFStream_getDuration       ( FFStream* );
    long       FFStream_getFrameCount     ( FFStream* );
    FFError    FFStream_setupVideoEncoder ( FFStream*, int, int, FFRational, FFOption* );
    FFError    FFStream_setupAudioEncoder ( FFStream*, int, int, FFOption* );

    struct FFWriter;
    FFWriter* FFWriter_new               ( const(char)* );
    void      FFWriter_delete            ( FFWriter** );
    FFError   FFWriter_checkError        ( FFWriter* );
    FFStream* FFWriter_createVideoStream ( FFWriter* );
    FFStream* FFWriter_createAudioStream ( FFWriter* );
    FFError   FFWriter_setMeta           ( FFWriter*, FFMeta* );
    FFStream* FFWriter_writeHeader       ( FFWriter* );
    FFError   FFWriter_encodeImage       ( FFWriter*, FFImage* );
    FFError   FFWriter_encodeSound       ( FFWriter*, FFSound* );
    FFError   FFWriter_flush             ( FFWriter* );
}
