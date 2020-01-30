//
//  DataStream.swift
//  JzIos_Framework
//
//  Created by 王建智 on 2020/1/1.
//  Copyright © 2020 王建智. All rights reserved.
//
import Foundation
open class DataStream:NSObject{
    var iStream: InputStream? = nil
    var oStream: OutputStream? = nil
    enum customError : Error{
        case Rinterror
        case Rutferror
        case Winterror
        case Wutferror
        case Openerror
    }
    public func close(){
        iStream?.close()
        oStream?.close()
    }
    public func SetStream(_ ip:String,_ port:Int)throws{
        let _  = Stream.getStreamsToHost(withName: ip, port: port, inputStream: &iStream, outputStream: &oStream)
        iStream?.open()
        oStream?.open()
        sleep(1)
        if(oStream?.streamStatus.rawValue==1){
            print("沒有連線")
            throw customError.Openerror
        }
    }
    public func writeINT(_ int:Int)throws{
        do{
            if(oStream?.streamStatus.rawValue==1){
                print("沒有連線")
                throw customError.Openerror
            }
            var alldata=Array(repeating: UInt8(0), count: 4)
            alldata[0]=UInt8(int/256/256/256)
            alldata[1]=UInt8((int%(256*256*256))/256/256)
            alldata[2]=UInt8((int%(256*256))/256)
            alldata[3]=UInt8(int%256)
            let writesize=oStream?.write(alldata, maxLength: alldata.count)
            if(writesize != alldata.count){ throw customError.Winterror}
        }catch{
            print("WriteInt錯誤")
            throw customError.Winterror
        }
    }
    public func writeUTF(_ string: String)throws{
        do{
            if(oStream?.streamStatus.rawValue==1){
                print("沒有連線")
                throw customError.Openerror
            }
            let data = (string).data(using: .utf8)
            let buf=[UInt8](data!)
            var alldata=Array(repeating: UInt8(0), count: 2)
            alldata[0]=UInt8(buf.count/256)
            alldata[1]=UInt8(buf.count%256)
            alldata += buf
            let writesize=oStream?.write(alldata, maxLength: alldata.count)
            print("size==\(writesize):\(alldata.count)")
            if(writesize != alldata.count){ throw customError.Wutferror}
        }catch {
            print("發生錯誤")
            throw customError.Wutferror
        }
    }
    public func writeUnicode(_ string: String)throws{
        do{
            if(oStream?.streamStatus.rawValue==1){
                print("沒有連線")
                throw customError.Openerror
            }
            let data = encode(string).data(using: .utf8)
            let buf=[UInt8](data!)
            var alldata=Array(repeating: UInt8(0), count: 2)
            alldata[0]=UInt8(buf.count/256)
            alldata[1]=UInt8(buf.count%256)
            alldata += buf
            let writesize=oStream?.write(alldata, maxLength: alldata.count)
            print("size==\(writesize):\(alldata.count)")
            if(writesize != alldata.count){ throw customError.Wutferror}
        }catch {
            print("發生錯誤")
            throw customError.Wutferror
        }
    }
    public func ReadUTf()throws ->String{
        var buf=Array(repeating: UInt8(255), count: 2)
        let tmp=iStream?.read(&buf, maxLength: 2)
        if(tmp==0){ throw customError.Rutferror}else{
            let long=Int(buf[0])*256+Int(buf[1])
            buf=Array(repeating: UInt8(255), count: 0)
            var readsize=0
            var fal=0
            while(readsize<long){
                if(oStream?.streamStatus.rawValue==1||fal>=10){
                    print("沒有連線")
                    throw customError.Openerror
                }
                var buf2=Array(repeating: UInt8(0), count: 1)
                let readcount=iStream!.read(&buf2, maxLength: 1)
                readsize += readcount
                if(readcount==1){buf += buf2}
                //                fal += 1
            }
            let data=Data(bytes: buf, count: long)
            let string = (String(decoding: data, as: UTF8.self))
            //            if(string.contains("�")){print("error"+bytesToHex(buf))}
            return string.replace("������", "�")
        }
    }
    public func readUniCode()throws ->String{
        var buf=Array(repeating: UInt8(255), count: 2)
        let tmp=iStream?.read(&buf, maxLength: 2)
        if(tmp==0){ throw customError.Rutferror}else{
            let long=Int(buf[0])*256+Int(buf[1])
            buf=Array(repeating: UInt8(255), count: 0)
            var readsize=0
            var fal=0
            while(readsize<long){
                if(oStream?.streamStatus.rawValue==1||fal>=10){
                    print("沒有連線")
                    throw customError.Openerror
                }
                var buf2=Array(repeating: UInt8(0), count: 1)
                let readcount=iStream!.read(&buf2, maxLength: 1)
                readsize += readcount
                if(readcount==1){buf += buf2}
                //                fal += 1
            }
            let data=Data(bytes: buf, count: long)
            let string = decode((String(decoding: data, as: UTF8.self)))
            //            if(string.contains("�")){print("error"+bytesToHex(buf))}
            return string.replace("�", "")
        }
    }
    public func decode(_ s: String) -> String {
        let data = s.data(using: .utf8)!
        return String(data: data, encoding: .nonLossyASCII) ?? s
    }
    public func encode(_ s: String) -> String {
        let dataenc = s.data(using: String.Encoding.nonLossyASCII)
        let encodevalue = String(data: dataenc!, encoding: String.Encoding.utf8) ?? s
        return encodevalue.replace("u","\\u")
    }
    public func bytesToHex(_ bt:[UInt8])->String{
        var re=""
        for i in 0..<bt.count{
            re=re.appending(String(format:"%02X",bt[i]))
        }
        return re
    }
    public func ReadInt()throws ->Int{
        var buf = Array(repeating: UInt8(0), count: 0)
        var readsize=0
        while(readsize<4){
            if(oStream?.streamStatus.rawValue==1){
                print("沒有連線")
                throw customError.Openerror
            }
            var buf2=Array(repeating: UInt8(0), count: 1)
            let readcount=iStream!.read(&buf2, maxLength: 1)
            readsize += readcount
            if(readcount==1){buf += buf2}
        }
            let int=Int(buf[0])*256*256*256+Int(buf[1])*256*256+Int(buf[2])*256+Int(buf[3])
            return int
      
    }
    public func ReadData(){
        var buf = Array(repeating: UInt8(255), count: 1024)
        //        buf.append(UInt8(9))
        if let n = iStream?.read(&buf, maxLength: 1024) {
            print(n)
            print(buf)
            print(Int(buf[0]))
        }
    }
}

