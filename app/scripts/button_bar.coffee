React = require "react"

Segments = require "./segments"
Selection = require "./selection"
Cursor = require "./cursor"

Dispatcher = require "./dispatcher"

#----------

ValidDownloadButton = React.createClass
    render: ->
        <a href={Selection.download_link()} className="btn btn-raised btn-success">Download Selection</a>

InvalidDownloadButton = React.createClass
    render: ->
        <button className="btn btn-raised btn-success disabled">Download Selection</button>

DownloadButton = React.createClass
    render: ->
        if @props.valid
            <ValidDownloadButton/>
        else
            <InvalidDownloadButton/>

#----------

SetPointButton = React.createClass
    render: ->
        classes = "btn btn-raised btn-info"

        onClick = =>
            Dispatcher.dispatch actionType:"selection-set-#{@props.point}", ts:@props.cursor

        if !@props.cursor || !Selection.validCursorFor(@props.point,@props.cursor)
            classes += " disabled"

        <button className={classes} onClick={onClick}>Set {@props.point}</button>

#----------

ClearSelectionButton = React.createClass
    render: ->
        onClick = => Dispatcher.dispatch actionType:"selection-clear"

        classes = "btn btn-raised btn-warning"

        if !@props.in && !@props.out
            classes += " disabled"

        <button className={classes} onClick={onClick}>Clear Selection</button>

#----------

PlayNow = React.createClass
    render: ->
        onClick = => Dispatcher.dispatch actionType:"play-now"

        classes = "btn btn-raised btn-info"

        <button className={classes} onClick={onClick}>play</button>

#----------

StopNow = React.createClass
    render: ->
        onClick = => Dispatcher.dispatch actionType:"stop-now"

        classes = "btn btn-raised btn-info"

        <button className={classes} onClick={onClick}>stop</button>
#----------

module.exports = React.createClass
       
    render: ->
        <div>
            <DownloadButton valid={@props.selectionValid}/>
            <ClearSelectionButton in={@props.selectionIn} out={@props.selectionOut}/>
            <SetPointButton point="in" in={@props.selectionIn} out={@props.selectionOut} cursor={@props.cursor}/>
            <SetPointButton point="out" in={@props.selectionIn} out={@props.selectionOut} cursor={@props.cursor}/>
            <PlayNow/>
            <StopNow/>
        </div>