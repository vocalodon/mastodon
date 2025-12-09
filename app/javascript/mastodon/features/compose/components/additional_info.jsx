import React from 'react';

import { Link } from 'react-router-dom';

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
          <li><Link to={'/tags/ボカロ丼自己紹介タイム'}>#ボカロ丼自己紹介タイム</Link></li>
          <li><Link to={'/tags/ボカロ丼お絵描き部'}>#ボカロ丼お絵描き部</Link></li>
          <li><Link to={'/tags/曲紹介'}>#曲紹介</Link></li>
          <li><Link to={'/tags/自貼り'}>#自貼り</Link></li>
          <li><Link to={'/tags/vocanew'}>#vocanew</Link></li>
        </ul>
        <h2>管理者</h2>
        <ul className='kakomi'>
          <li><Link to={'/@tomoki'}>TOMOKI++</Link></li>
        </ul>
      </div>
    );
  }

}

