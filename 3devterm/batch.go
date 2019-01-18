package main

import (
    "fmt"
    //"reflect"
	//"sync"

	
	"strconv"
	"encoding/json"
	"io/ioutil"
	"time"
	//"github.com/jmcvetta/napping"
	//"runtime"
	"net/http"
    "strings"
	//"bytes"

)

var list = [...]string{
0x4d713f3d8b1b53a5bb84f2907b4c4dd315e8c992,
0x491e0f76472aa5bdda8ab88fc9c6ac983784791f,
0x83dbc16a850159d768f7372751e70a5ea435afe1,
0x65fd6e1472f588f43a41938db98c248768359ab9,
0xb27722ec16934a6d7ed967652726969a5747a060,
0xff4c160efd043a3bf92f60f3df74cf0f7b1d951a,
0x221121e3916dad9bdeb91a70ae4901973ea3c6c5}


type Tx struct {

	From  string   `json:"from"`

	To  string `json:"to"`

	Value string   `json:"value"`
	Gas string `json:"gas"`

}
type Data struct {
	Txs []Tx	`json:"params"`

	Id  int   `json:"id"`

	Jsonrpc  string `json:"jsonrpc"`

	Method string   `json:"method"`

}
type Acc struct {
	Params []string	`json:"params"`

	Id  int   `json:"id"`

	Jsonrpc  string `json:"jsonrpc"`

	Method string   `json:"method"`

}
func  geta(url string,data string,c http.Client) []string {
	//fmt.Println(data)

	req, _ := http.NewRequest("POST", url, strings.NewReader(data))
	//
	req.Header.Set("Content-Type", "application/json")

	resp, err := c.Do(req)
	if err != nil {
		panic(err)
	}
	defer resp.Body.Close()
	//defer wg.Add(-1)
	body, _ := ioutil.ReadAll(resp.Body)
	
	//fmt.Println("response Body:", bytes.NewBuffer(body).String() )
	
	type re struct{
		Id  int   `json:"id"`

		Jsonrpc  string `json:"jsonrpc"`

		Result []string  `json:"result"`
	}
	var res re
	if err := json.Unmarshal(body, &res); err != nil {
		fmt.Println(err)
	}
	return res.Result
}
func Tool_DecimalByteSlice2HexString(DecimalSlice []byte) string {
    var sa = make([]string, 0)
    for _, v := range DecimalSlice {
        sa = append(sa, fmt.Sprintf("%02X", v))
    }
    ss := strings.Join(sa, "")
    return ss
}

func  send(url string,data string,c http.Client)  {
	//fmt.Println(data)

	req, _ := http.NewRequest("POST", url, strings.NewReader(data))
	//
	req.Header.Set("Content-Type", "application/json")

	resp, err := c.Do(req)
	if err != nil {
		panic(err)
	}
	defer resp.Body.Close()
	//defer wg.Add(-1)
	//body, _ := ioutil.ReadAll(resp.Body)
	//fmt.Println("response Body:", bytes.NewBuffer(body).String() )
}
//var wg sync.WaitGroup
func main() {

	url := "http://127.0.0.1:18541"
	//
	var acc Acc
	acc.Method = "hpb_accounts"
	acc.Jsonrpc ="2.0"
	acc.Id = 67
	acc.Params=nil
	acc_d,_:=json.Marshal(acc)
	

	c := &http.Client{}
	datas := make([]interface{},0)
	//ress :=geta(url,string(acc_d),*c)
	
	num :=float64(600)
	for i:=1;i<int(num);i++{
		ss:=Data{}
		ss.Method = "hpb_sendTransaction"
		ss.Jsonrpc ="2.0"
		ss.Id = 67
		tx_ :=Tx{}
		tx_.From = list[0]
		tx_.To = list[1]
		//wg.Add(1)
		
		
		tx_.Value = "0x" + strconv.FormatInt(int64(1000000*i), 16)
		tx_.Gas = "0x" + strconv.FormatInt(int64(21000), 16)

		ss.Txs = append(ss.Txs,tx_)
		//b,_:= json.Marshal(ss)
		datas = append(datas, ss)
		//send(url,string(b),*c)
	}
	//wg.Wait()
	
	
	b,_:= json.Marshal(datas)
	
	//nnn :=300
	//t :=time.Now()
	for i:=1;i<171;i++ {
		//t1 :=time.Now()
		send(url,string(b),*c)
		//t2 :=time.Now()
		//dd :=t2.Sub(t1).Seconds()
		fmt.Println(i," total time :")
		time.Sleep(100*time.Millisecond)
	}
	

	
	
}
