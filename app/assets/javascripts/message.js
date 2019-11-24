$(function(){
  function buildHTML(message){
    if (message.image) {
      var html =//メッセージに画像が含まれる場合のHTMLを作る
      `<div class="message__box">
        <div class="message__box__title">
          <div class="talker">
            ${message.user_name}
          </div>
          <div class="date">
            ${message.date}
          </div>
        </div>
        <div class="message__box__text">
          <p class="message__box__text__content">
            ${message.content}
          </p>
        </div>
          <img src=${message.image}>
      </div>`
      return html;
    } else {
      var html = //メッセージに画像が含まれない場合のHTMLを作る
      `<div class="message__box">
        <div class="message__box__title">
          <div class="talker">
            ${message.user_name}
          </div>
          <div class="date">
            ${message.date}
          </div>
        </div>
        <div class="message__box__text">
          <p class="message__box__text__content">
            ${message.content}
          </p>
        </div>
      </div>`
    return html;
  };
}

  $('#new_message').on('submit',function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action')
    $.ajax({
      url: url,  //同期通信でいう『パス』
      type: 'POST',  //同期通信でいう『HTTPメソッド』
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(message){
      var html = buildHTML(message);
      $('.message').append(html);
      $('.message').animate({ scrollTop: $('.message')[0].scrollHeight});
      $('form')[0].reset();
    })
    .fail(function(){
      alert('error');
    })
    return false;
  })
})