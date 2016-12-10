@Client = React.createClass
  getInitialState: ->
    edit: false
  handleToggle: (e) ->
    e.preventDefault()
    @setState edit: !@state.edit
  handleEdit: (e) ->
    e.preventDefault()
    data =
      first_name: ReactDOM.findDOMNode(@refs.first_name).value
      last_name: ReactDOM.findDOMNode(@refs.last_name).value
      email_address: ReactDOM.findDOMNode(@refs.email_address).value
      phone_number: ReactDOM.findDOMNode(@refs.phone_number).value
      company_name: ReactDOM.findDOMNode(@refs.company_name).value
    $.ajax
      method: 'PUT'
      url: "/clients/#{ @props.client.id }"
      dataType: 'JSON'
      data:
        client: data
      success: (data) =>
        @setState edit: false
        @props.handleEditClient @props.client, data
  handleDelete: (e) ->
    e.preventDefault()
    $.ajax
      method: 'DELETE'
      url: "/clients/#{ @props.client.id }"
      dataType: 'JSON'
      success: () =>
        @props.handleDeleteClient @props.client
  clientForm: ->
    React.DOM.tr null,
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.client.first_name
          ref: 'first_name'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.client.last_name
          ref: 'last_name'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.client.email_address
          ref: 'email_address'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.client.phone_number
          ref: 'phone_number'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.client.company_name
          ref: 'company_name'
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-xs btn-success'
          onClick: @handleEdit
          React.DOM.i
            className: 'glyphicon glyphicon-ok'
        React.DOM.a
          className: 'btn btn-xs btn-danger'
          onClick: @handleToggle
          React.DOM.i
            className: 'glyphicon glyphicon-remove'
  clientRow: ->
    React.DOM.tr null,
      React.DOM.td null, @props.client.first_name
      React.DOM.td null, @props.client.last_name
      React.DOM.td null, @props.client.email_address
      React.DOM.td null, @props.client.phone_number
      React.DOM.td null, @props.client.company_name
      React.DOM.td
        className: 'text-center'
        React.DOM.div
          className: 'btn-group'
          React.DOM.a
            className: 'btn btn-xs btn-default'
            onClick: @handleToggle
            React.DOM.i
              className: 'glyphicon glyphicon-pencil'
          React.DOM.a
            className: 'btn btn-xs btn-danger'
            onClick: @handleDelete
            React.DOM.i
              className: 'glyphicon glyphicon-remove'
  render: ->
    if @state.edit
      @clientForm()
    else
      @clientRow()
