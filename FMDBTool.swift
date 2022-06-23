//
//  FMDBTool.swift
//  MVVMDemo
//
//  Created by Chao Lv on 2022/6/23.
//

import UIKit
import FMDB

class FMDBTool: NSObject {
    
    static let shareManager = FMDBTool()
    
    var fmdb : FMDatabase?
    
    //通过加锁保证所做操作数据的安全性
    let lock = NSLock()
    
    override init() {
        //设置数据库的存储路径
        let path = NSHomeDirectory().appending("/Documents/fmdb.sqlite")
        self.fmdb = FMDatabase(path: path)
        if ((fmdb?.open()) != nil) {
            print("打开数据库成功")
        }else{
            print("打开数据库失败")
        }
        
    }
    
    
    // 创建一个数据库 以及定义数据库存储的字段名
    //student表达表名，由自己命名
    //userName,passWord是需要收藏的模型中的字段，须根模型中保持一致
    //varchar表示字符串，integer表示数字，blob表示二进制数据NSData
    func createDataTable(createSql : String)  {
        let creeateSql = "create table if not exists student(userName varchar(1024),passWord varchar(1024))"
        //执行sel语句进行数据库的创建
        do {
            try self.fmdb!.executeUpdate(creeateSql, values: nil)
        }catch {
            print(self.fmdb!.lastErrorMessage())
        }
    }
    
    
  
    
    /// 增加数据
    /// - Parameters:
    ///   - sql: 增加数据库的sql语句
    ///   - values: 增加数据的属性值
    func insertDataWith(sql : String,values:[Any]?)  {
        self.lock.lock()
        let insertSql = "insert into student(userName, passWord) values(?,?)"
        
        do {
            try self.fmdb?.executeUpdate(insertSql, values: values)
        } catch  {
            print(self.fmdb?.lastErrorMessage() ?? "增加失败")
        }
        self.lock.unlock()
    }
    
    
    /// 删除数据
    /// - Parameters:
    ///   - sql: 删除数据库的sql语句
    ///   - values: 删除数据库的查询条件
    func deleteDataWith(sql: String , values: [Any])  {
        self.lock.lock()
        let deleteSql = "delete from student where userName = ?"
        
        do {
            try self.fmdb?.executeUpdate(deleteSql, values: values)
        } catch  {
            print(self.fmdb?.lastErrorMessage() ?? "删除失败")
        }
        self.lock.unlock()
    }
    
    
    /// 更改数据库的sql语句
    /// - Parameters:
    ///   - sql: 更改数据库的sql语句
    ///   - values: 更改数据库的值
    ///   - bySql: 更改数据库值的查询条件
    func updateDataWith(sql : String , values : [Any] , bySql: Any) {
        self.lock.lock()
        let updateSql = "update student set userName = ?,passWord = ? where id = ?"
        
        do {
            try self.fmdb?.executeUpdate(updateSql, values: values)
        } catch  {
            print(self.fmdb?.lastErrorMessage() ?? "更改失败")
        }
        self.lock.unlock()
    }
    
    //5.判断数据库中是否有当前数据(查找一条数据)
    func isHasDataInTable(sql : String , values : [Any] ) -> Bool {

        let isHas = "select * from student where userName = ?"
        do{
            let set = try self.fmdb?.executeQuery(isHas, values: values)
            //查找当前行，如果数据存在，则接着查找下一行
            if ((set?.next()) != nil) {
                return true
            }else {
                return false
            }
        }catch {
            print(self.fmdb?.lastErrorMessage() ?? "判断失败")
        }

        return true
    }
    
    /// 查找全部数据
    /// - Returns: 返回的全部数据
    func fetchAllData() ->[Any] {

        let fetchSql = "select * from student"
        //用于承接所有数据的临时数组
        var tempArray = [Any]()
        do {
            let set = try self.fmdb?.executeQuery(fetchSql, values: nil)
            //循环遍历结果
            while ((set?.next()) != nil) {
               
                //给字段赋值
                let userName = set?.string(forColumn: "username")
//                let passWord = set?.string(forColumn: "password")
                tempArray.append(userName ?? "")
            }
        }catch {
            print(self.fmdb?.lastErrorMessage() ?? "")
        }
        
        return tempArray
      }
    
    

}
