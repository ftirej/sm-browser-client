Backbone = require "backbone"
Dispatcher = require "./dispatcher"
AudioManager = require "./audio_manager"
Cursor = require "./cursor"

module.exports = class extends Backbone.Model
    constructor: (@audio) ->
        @_audio = @audio
        @dispatchToken = Dispatcher.register (payload) =>
            switch payload.actionType
                when "play-now"
                    console.log("Play")                    
                    if @_audio.playing()
                        console.log "Stopping"
                        @_audio.stop()
                    else
                        if ts = Cursor.get('ts')
                            console.log ts
                            console.log "Playing", ts
                            @_audio.play ts
                when "stop-now"
                    if @_audio.playing()
                        console.log "Stopping"
                        @_audio.stop()
                    console.log("Stop")


