$ ->
  document.addEventListener 'trix-attachment-add', (event) ->
    attachment = event.attachment
    sendFile(attachment) if attachment.file

  document.addEventListener 'trix-attachment-remove', (event) ->
    attachment = event.attachment
    deleteFile attachment

  sendFile = (attachment) ->
    file = attachment.file
    form = new FormData
    form.append 'Content-Type', file.type
    form.append 'file', file, 'image.png'
    form.append 'authenticity_token', authenticity_token
    xhr = new XMLHttpRequest
    xhr.open 'POST', '/uploads', true

    xhr.upload.onprogress = (event) ->
      progress = undefined
      progress = event.loaded / event.total * 100
      attachment.setUploadProgress progress

    xhr.onload = ->
      response = JSON.parse(@responseText)
      attachment.setAttributes
        url: response.url
        image_id: response.id
        href: response.url

    xhr.send form

  deleteFile = (n) ->
    $.ajax
      type: 'DELETE'
      url: "/uploads/#{n.attachment.attributes.values.image_id}?authenticity_token=#{authenticity_token}"
      cache: false
      contentType: false
      processData: false
