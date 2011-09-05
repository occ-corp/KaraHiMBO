language: ja
フィーチャ: メイン画面の移動
  シナリオ: 管理者権限を持たないユーザはメンテナンス画面のリンクは表示されない
    前提 "畑本 アリア"でログインしている
    かつ "トップ"ページを表示している
    ならば "Setting"と表示されていないこと

  シナリオ: 項目のメンテナンス画面(部署選択)を開く
    前提 "蓼 庄二郎"でログインしている
    かつ "トップ"ページを表示している
    もし "Setting"リンクをクリックする
    ならば "メンテナンス画面"ページを表示していること
    かつ "全社"と表示されていること

  シナリオ: 項目のメンテナンス画面(部署選択)を開く
    前提 "蓼 庄二郎"でログインしている
    かつ "全社"のメンテナンス画面を表示している
    ならば "全社"と表示されていること

  @selenium
  シナリオ: エクスポート画面を開く
    前提 "畑本 アリア"でログインしている
    かつ "トップ"ページを表示している
    かつ エビデンスを取得する
    もし "export_button"ボタン2をクリックする
    ならば "エクスポート画面"ページを表示していること
    かつ エビデンスを取得する