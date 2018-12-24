import React, { Component } from 'react';
import Header from './Header';
import Banner from './Banner';
import {LoginPopup} from './Login'

export default class Home extends Component{
    render() {
        return(
            <div>
                <Header/>
                <LoginPopup/>
                <div className="grid-container">
                    <Banner type='Student'/>
                    <Banner type='Secretary'/>
                    <Banner type='Publisher'/>
                    <Banner type='Distributor'/>
                </div>
            </div>
        );
    }
}