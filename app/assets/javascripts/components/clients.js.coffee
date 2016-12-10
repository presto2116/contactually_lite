@Clients = React.createClass
  getInitialState: ->
    sorted_data = @props.data.sort (a, b) ->
      emailA = a.email_address.toLowerCase()
      emailB = b.email_address.toLowerCase()
      if emailA < emailB
        return -1
      if emailA > emailB
        return 1
      0
    clients: sorted_data
    onlyDotCom: false
  getDefaultProps: ->
    clients: []
  toggleDotCom: (e) ->
    e.preventDefault()
    data = @props.data
    if @state.onlyDotCom == false
      onlyDotComData = []
      $.each data, (client) ->
        if data[client]['email_address'].includes ".com"
          onlyDotComData.push data[client]
        return
      @replaceState clients: onlyDotComData
    else
      @replaceState clients: data
    @setState onlyDotCom: !@state.onlyDotCom
  deleteClient: (client) ->
    index = @state.clients.indexOf client
    clients = React.addons.update(@state.clients, { $splice: [[index, 1]] })
    @replaceState clients: clients
  updateClient: (client, data) ->
    index = @state.clients.indexOf client
    clients = React.addons.update(@state.clients, { $splice: [[index, 1, data]] })
    @replaceState clients: clients
  render: ->
    React.DOM.div
      className: 'clients'
      React.DOM.h2
        className: 'title'
        'Client List'
      React.DOM.div
        className: 'table-responsive'
        React.DOM.table
          className: 'table table-bordered'
          React.DOM.thead null,
            React.DOM.tr
              className: 'header-center'
              React.DOM.th null, 'First Name'
              React.DOM.th null, 'Last Name'
              React.DOM.th null, 'Email',
                React.DOM.button
                  onClick: @toggleDotCom
                  className: 'btn btn-xs btn-primary pull-right'
                  if @state.onlyDotCom
                    'Show All'
                  else
                    'Only .com'
              React.DOM.th null, 'Phone Number'
              React.DOM.th null, 'Company'
              React.DOM.th null, 'Actions'
          React.DOM.tbody null,
            for client in @state.clients
              React.createElement Client, key: client.id, client: client, handleDeleteClient: @deleteClient, handleEditClient: @updateClient

