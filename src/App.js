
import React, { useState, useEffect, useRef } from 'react';

import lihkgIcon from './Media/lihkg.png';
import './App.css';

import Web3 from 'web3';
import { MetaMaskButton,Flex, Box, EthAddress,Loader,Select,Field} from 'rimble-ui';


// for const LIHKGCOIN= new web3.eth.Contract()
import LIHKGCOIN from './abi/LIHKGCOIN.json'


function App() {

   // State

   let [account,setAccount] = useState("CONNECT YOUR WALLET");
   let [deployed,setDeployed] = useState(false);
   const [lihkgCoinAddress,setlihkgCoinAddress] = useState("");
   const [lihkgCoins,setlihkgCoins] = useState();
   let [lihkgCoinBalances,setlihkgCoingBalances] = useState();

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
       console.log(lihkgCoin)
      setlihkgCoins(lihkgCoins)


      let lihkgCoinAdd = lihkgCoin._address;
      await setlihkgCoinAddress(lihkgCoinAdd);
      console.log(lihkgCoin._address)

      let lihkgCoinBalance = await lihkgCoin.methods.balanceOf(accounts[0]).call()
      setlihkgCoingBalances(lihkgCoinBalance/100000000000000000)

      setDeployed(true)
      
     }

     


     
    

     
   }
 
 
   

   
   return false;
 }
 
 const refreshPage = ()=> {
   window.location.reload(false);
 }
 



  return (
    <div className="App">
       <h1>LIHKG COIN</h1>
      <div></div>
       <img src={lihkgIcon} alt="Lihkg Icon"/>


       {/* Connect Metamsk wallet */}

    <div className="metaMaskButton">
    <div>MetaMask Wallet Connect:</div>
    
    <MetaMaskButton className="spacingTop" onClick={ethEnabled,refreshPage}>Connect with Wallet</MetaMaskButton>
    <div>
    {account}
    </div>
    <div class="contractAddress">
      Contract Address: 
      </div>
      <div>
      {lihkgCoinAddress}
    </div>
    <div class="balance">
       LIHKGCOIN Balances:
    </div>
    <div >
      {lihkgCoinBalances}
    </div>
    <div>
      {}
    </div>
   
    

    {/* {account} */}
    </div>
    


{/* Connect Metamsk wallet */}
     
    </div>
  );
}

export default App;
