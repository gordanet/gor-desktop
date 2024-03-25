import {GorWallet as BaseGorWallet} from '/node_modules/@gor/ux/gor-ux.js';

class GorWallet extends BaseGorWallet{
	makeFaucetRequest(subject, args){
		let origin = 'https://faucet.gornet.io';
		//origin = 'http://localhost:3000';
		const {address, amount} = args;
		let path = {
			'faucet-available': `available/${address}`,
			'faucet-request': `get/${address}/${amount}`
		}[subject];

		if(!path)
			return Promise.reject("Invalid request subject:"+subject)

		return fetch(`${origin}/api/${path}`, {
			method: 'GET'
		}).then(res => res.json())
	}
}

GorWallet.define("gor-wallet")
