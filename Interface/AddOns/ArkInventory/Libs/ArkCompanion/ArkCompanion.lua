local MAJOR, MINOR = "ArkCompanion-1.0", 1
local lib, oldminor = LibStub:NewLibrary( MAJOR, MINOR )

if not lib then return end

lib.callbacks = lib.callbacks or LibStub( "CallbackHandler-1.0" ):New( lib )
lib.event_frame = lib.event_frame or CreateFrame( "FRAME" )
lib.event_frame:SetScript( "OnEvent", function( frame, event, ... )
    frame[event]( frame, ... )
end )
