/* APPELS DE PROCEDURES*/


call registerClient(_nom varchar(50), _mail varchar(255),_num varchar(30), _adresse varchar(255))
call registerTranspo(_nom varchar(50), _mail varchar(255), _adresse varchar(255))
call addProduct(_idC text, _nom varchar(255), _pu float, _masse float, _volume float, _descrip text)
call addCat(_idC text, _nom varchar(255))
call addMode(_idM text, _nom varchar(255))
call orderP(idP varchar(50))
call SetStatusC(_idc varchar(50), _status bool)
call SetStatusT(_idc varchar(50), _status bool)
call SetStatusCat(_idc varchar(50), _status bool)
call SetStatusP(_idc varchar(50), _status bool)



/* EXECUTION DE FONCTIONS */
select  formId (_k int, _c varchar(6))
select  cmTelBox ()
select  clientIdback(_nom varchar(50), _mail varchar(255),_num varchar(30), _adresse varchar(255))
select  Pu_lim()
select  Qte_lim()
select  testClientId(_idc varchar(50))
select  testCatId(_idc varchar(50))
select  testProdId(_idc varchar(50))
select  testTranspId(_idc varchar(50))
