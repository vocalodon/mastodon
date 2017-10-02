import React from 'react';
import PropTypes from 'prop-types';

export default class AdditionalInfo extends React.PureComponent {

  render () {
    return (
      <div className='additional-info'>
        <h2>お知らせ(information)</h2>
        <ul className='kakomi'>
          <li><h3>Info1</h3></li>
          <li>
            <ul>
              <li>text</li>
              <li>text</li>
              <li>text</li>
              <li>text</li>
            </ul>
          </li>
          <li><h3>Info2</h3></li>
          <li>
            <ul>
              <li>text</li>
              <li>text</li>
              <li>text</li>
              <li>text</li>
            </ul>
          </li>
        </ul>
        <h2>主なハッシュタグ</h2>
        <ul className='kakomi'>
          <li><a href="/web/timelines/tag/ボカロ丼自己紹介タイム">#ボカロ丼自己紹介タイム</a></li>
          <li><a href="/web/timelines/tag/ボカロ丼お絵描き部">#ボカロ丼お絵描き部</a></li>
          <li><a href="/web/timelines/tag/曲紹介">#曲紹介</a></li>
          <li><a href="/web/timelines/tag/自貼り">#自貼り</a></li>
        </ul>
        <h2>管理者</h2>
        <ul className='kakomi'>
          <li><a href="/web/accounts/1">TOMOKI++</a></li>
        </ul>
      </div>
    );
  }

}

