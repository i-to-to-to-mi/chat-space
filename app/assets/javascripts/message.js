$(function(){
  // $(document).on('turbolinks:load', function(e){
  //   e.preventDefault();
  // if (window.location.href.match(/\/groups\/\d+\/messages/)){//今いるページのリンクが/groups/グループID/messagesのパスとマッチすれば以下を実行。
    function buildHTML(message){
      let image= message.image ?`<img class= "lower-message__image" src=${message.image} >` : "" //三項演算子を使ってmessage.imageにtrueならHTML要素、faiseなら空の値を代入。
      // let image= message.image ? 
      // `<img src=${message.image}>
      // ` : "";
      let html =`<div class="message__box", data-message-id="${message.id}">
                    <div class="message__box__title">
                      <div class="talker">
                        ${message.user_name}
                      </div>
                      <div class="date">
                        ${message.created_at}
                      </div>
                    </div>
                    <div class="message__box__text">
                      <p class="message__box__text__content">
                        ${message.content}
                      </p>
                        ${image}
                    </div>
                  </div>`
  // $('.messages').append(html);


// }
    return html;
  }
// インクリメンタルサーチ
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
      var html=buildHTML(message);
        $('.message').append(html);
        $('.message').animate({ scrollTop: $('.message')[0].scrollHeight});
        $('form')[0].reset();
    })
    .fail(function(){
      alert('error');
    })
    return false;
    })
// 自動更新機能
  let reloadMessages = function () { //カスタムデータ属性を利用し、ブラウザに表示されている最新メッセージのidを取得
    if (window.location.href.match(/\/groups\/\d+\/messages/)){      
      // let href = 'api/messages#index {:format=>"json"}' 
    let last_message_id = $('.message__box:last').data("message-id"); //dataメソッドで.messageにある:last最後のカスタムデータ属性を取得しlast_message_idに代入。
    // var group_id = $(".group").data("group-id");
    $.ajax({
      url: "api/messages",//ルーティングで設定した通りhttpメソッドをgetに指定
      // url: href,
      type: 'GET',
      dataType: 'json',
      data: {id: last_message_id}//dataオプションでリクエストに値を含める
    })
  .done(function(messages) {//通信成功したら、controllerから受け取ったデータ（messages)を引数にとって以下のことを行う
    let insertHTML = '';//追加するHTMLの入れ物を作る
    messages.forEach(function (message) {//配列messagesの中身一つ一つを取り出し、HTMLに変換したものを入れ物に足し合わせる
    insertHTML = buildHTML(message);//メッセージが入ったHTMLを取得
    $('.message').append(insertHTML);//メッセージを追加
    });
    $('.message').animate({ scrollTop: $('.message')[0].scrollHeight},'fast');
  })
    .fail(function() {
      alert('自動更新に失敗しました');//ダメだったらアラートを出す    
    });
    };
    };
    setInterval(reloadMessages, 7000);//7000ミリ秒ごとにreloadMessagesという関数を実行し自動更新を行う。
  });
// })