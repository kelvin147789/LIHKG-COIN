
import React, { useState, useEffect, useRef } from 'react';
import {HashRouter,Route, Switch,Link} from "react-router-dom";
import lihkgIcon from './Media/lihkg.png';
import './App.css';

import Web3 from 'web3';
import { MetaMaskButton,Flex, Box, EthAddress,Loader,Select,Field} from 'rimble-ui';


// for const LIHKGCOIN= new web3.eth.Contract()
import LIHKGCOIN from './abi/LIHKGCOIN.json'
import LIHKGCSTAKE from './abi/LIHKGCSTAKE.json'


const NavBar = (props)=> {

  return (
    <div className="navBar">

      
      <ul>
       
       <div className="navBarMain">
      
      <span>   
      <a href="#">  
         <img src={lihkgIcon} alt="Lihkg Icon" className="navIcon" />  
         
       <h3>LIHKG COIN</h3>
       </a>
      

       </span>
     
     
       
       <div>
        <a href="https://lihkg-coin.gitbook.io/lihkg-coin" target="_blank">
       <h2 className="balance">Docs</h2>
       </a>
       </div>

       <div>
         <h2>Hello</h2>
       </div>

       </div>
      
        
       
   

      
          <div className="navBarWallet">    
          
          <EthAddress address={props.account} />    
            <MetaMaskButton    width= {0.5}onClick={props.ethEnabled,props.refreshPage}>Connect Wallet</MetaMaskButton>   
          </div>

        

         

      
       
      </ul>

    </div>
  );
  
}

const Home = (props)=> {
  


    



  return(
         <div>
     
   
      


       {/* Connect Metamsk wallet */}

    <div className="metaMaskButton">
  
    <div>
    </div>
   
   
  
    <div class="contractAddress">
      LIHKGC Address: 
      </div>
    
      {props.lihkgCoinAddress}
  
    <div class="balance">
       LIHKGCOIN Balances:
    </div>

  
      {props.lihkgCoinBalances}


    <div className="stakeAddress"> LIHKGC Stake Address:</div>
    {props.lihkgcStakeAddress}
    



    <div>
    <div class="buttons">
  <div class="container"onClick={props.agree5DemandNot1Less} >
      <i class="btn effect04" data-sm-link-text="缺一不可" ><span>五大訴求</span></i>
  </div>
</div>
    </div>

   

    <div>
    <div class="buttons claim-button">
  <div class="container"onClick={props.claimLIHKGC} >
      <i class="btn effect04" data-sm-link-text="請先同意五大訴求" ><span>Claim LIHKGC</span></i>
  </div>
</div>
    </div>
    {/* {account} */}
    </div>
         </div>
  )
}


let Setting = (props)=> {
  return(
    <div>Setting</div>
  )
}





function App() {

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



   // State



  

  return (
   
      <HashRouter>
       <div className="App">

         <NavBar  
         refreshPage={refreshPage}
         ethEnabled={ethEnabled}
         account={account}
         />

       
         <Switch>
         <Route exact path="/" render={(props)=> (
         <Home 
         account={account}
         refreshPage={refreshPage}
         claimLIHKGC={claimLIHKGC}
         agree5DemandNot1Less={agree5DemandNot1Less}
         lihkgcStakeAddress={lihkgcStakeAddress}
         lihkgcStake={lihkgcStakeAddress}
         lihkgCoinBalances={lihkgCoinBalances}
         lihkgCoinAddress={lihkgCoinAddress}
         />)}/>

        <Route  path="/setting" render={(props)=> (
         <Setting 
         
         />)}/>


        

         </Switch>
        
        
      </div>
      </HashRouter>

   
  );

  
}






export default App;
