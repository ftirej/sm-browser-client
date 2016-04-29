React = require "react"
moment = require "moment"
require "moment-duration-format"

Segments = require "./segments"
Selection = require "./selection"
Cursor = require "./cursor"

AudioInfo = React.createClass
        render: ->
            sTs = if @props.start then moment(@props.start).format('MMM DD, h:mm:ssa') else '--'
            eTs = if @props.end then moment(@props.end).format('MMM DD, h:mm:ssa') else '--'
            
            <div className="panel panel-primary">
                <div className="panel-heading">
                    <h3 className="panel-title">Available Audio</h3>
                </div>
                <div className="panel-body">
                    {sTs} to {eTs}
                </div>
            </div>

#----------

SelectionInfo = React.createClass
    render: ->
        ints = if @props.in then moment(@props.in).format("MMM DD, h:mm:ss.SSSa") else "--"
        outts = if @props.out then moment(@props.out).format("MMM DD, h:mm:ss.SSSa") else "--"

        duration = if @props.in && @props.out
            moment.duration(moment(@props.out).diff(@props.in)).format("h [hrs], m [min], s [sec], S [ms]")
        else
            "--"
        <div>
            <div className="panel panel-info">
                <div className="panel-heading">
                    Selection
                </div>
                <div className="panel-body">
                    <b>In:</b> {ints} <b>Out</b>: {outts}
                </div>
            </div>
            
            <div className="panel panel-success">
                <div className="panel-heading">
                    Duration
                </div>
                <div className="panel-body">
                    {duration}
                </div>
            </div>
        </div>

#----------

CursorInfo = React.createClass
    render: ->
        cursorts = if @props.ts then moment(@props.ts).format("MMM DD, h:mm:ss.SSSa") else "--"
        
        
        <div className="panel panel-danger">
            <div className="panel-heading">
                Cursor
            </div>
            <div className="panel-body">
                {cursorts}
            </div>
        </div>

#----------

module.exports = React.createClass
    render: ->
        <div className="info row">
            <div className="col-md-6">
                <AudioInfo start={@props.audioStart} end={@props.audioEnd}/>
                <CursorInfo ts={@props.cursor}/>
            </div>
            <div className="col-md-6">
                <SelectionInfo in={@props.selectionIn} out={@props.selectionOut}/>
            </div>
        </div>
