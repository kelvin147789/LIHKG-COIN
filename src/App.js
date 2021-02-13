
import React, { useState, useEffect, useRef } from 'react';
import {HashRouter,Route, Switch} from "react-router-dom";
import lihkgIcon from './Media/lihkg.png';
import './App.css';

import Web3 from 'web3';
import { MetaMaskButton,Flex, Box, EthAddress,Loader,Select,Field} from 'rimble-ui';


// for const LIHKGCOIN= new web3.eth.Contract()
import LIHKGCOIN from './abi/LIHKGCOIN.json'
import LIHKGCSTAKE from './abi/LIHKGCSTAKE.json'

const Home = (props)=> {
  return(
    <div>Home</div>
  )
}
const Setting = (props)=> {
  return(
    <div>Setting</div>
  )
}





function App() {

   // State

   let [account,setAccount] = useState("CONNECT YOUR WALLET");
   let [deployed,setDeployed] = useState(false);
   const [lihkgCoinAddress,setlihkgCoinAddress] = useState("");
   const [lihkgcStakeAddress,setlihkgcStakeAddress] = useState("");
   const [lihkgCoins,setlihkgCoins] = useState();
   const [lihkgcStake,setlihkgcStake] = useState();
   let [lihkgCoinBalances,setlihkgCoingBalances] = useState();
   const [uint256,setuint256] = useState(1000000000000000000);

   // State
 
     useEffect(() => {
       ethEnabled();
     
     }
     )
 
 
 
 
 const ethEnabled = async() => {
   
   if (window.web3) {
     window.web3 = new Web3(window.web3.currentProvider);
     await window.ethereum.enable();
 
     const web3js = await window.web3;
     const accounts = await web3js.eth.getAccounts();
     const networkID = await web3js.eth.net.getId();
     setAccount(accounts[0]);  

     console.log("Account connected");

     const lihkgCoinData = await LIHKGCOIN.networks[networkID]

     if (lihkgCoinData && !deployed)
     {
       const lihkgCoin = await new web3js.eth.Contract(LIHKGCOIN.abi,lihkgCoinData.address)
       console.log("LIHKGC",lihkgCoin)
      setlihkgCoins(lihkgCoin)

      


      let lihkgCoinAdd = lihkgCoin._address;
      await setlihkgCoinAddress(lihkgCoinAdd);
      console.log("lihkgcoin address", lihkgCoin._address)

      const lihkgCoinBalance = await lihkgCoin.methods.balanceOf(accounts[0]).call()
      await setlihkgCoingBalances(lihkgCoinBalance/uint256)

      setDeployed(true)

        const lihkgcStakeData = await LIHKGCSTAKE.networks[networkID]
        if (lihkgcStakeData)
        {
            const lihkgcStake = await new web3js.eth.Contract(LIHKGCSTAKE.abi,lihkgcStakeData.address)
            console.log("Stake Contract",lihkgcStake)
            setlihkgcStake(lihkgcStake)

        let lihkgcStakeAdd = lihkgcStake._address;
        console.log("Stake address", lihkgcStakeAdd)
        setlihkgcStakeAddress(lihkgcStakeAdd)
        
        }
    

     
     }

     
     
   }

   return false;
 }
 
 const refreshPage = ()=> {
   window.location.reload(false);
 }


//  Contract Method
const claimLIHKGC = async()=> {

  if (lihkgCoins)
  {
    lihkgCoins.methods.claimLIHKGC().send({
      from: account
     
    })
    console.log(lihkgCoinAddress)
    
  }
  
}


const agree5DemandNot1Less = async()=> {

  if (lihkgCoins)
  {
    lihkgCoins.methods.agreeStatement().send({
      from: account
     
    })
    console.log('Agree 5 Demand Not 1 Less')

  }
  
}
 



  return (
   
      <HashRouter>
       <div className="App">
         <Switch>
         <Route exact path="/" component={Home}/>
         <Route path="/Setting" component={Setting}/>

         </Switch>
        
        
      </div>
      </HashRouter>










     
   
  );
}




export default App;
