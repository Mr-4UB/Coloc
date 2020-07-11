class Demande {
  String _demandebudget;
  String _demandedetails;
  String _demandedate;
  String _demandetime;
  String _demandetype;

  Demande(this._demandebudget, this._demandedetails, this._demandedate,
      this._demandetime, this._demandetype);

  Demande.map(dynamic obj) {
    this._demandebudget = obj['demandebudget'];
    this._demandedetails = obj['demandedetails'];
    this._demandedate = obj['demandedate'];
    this._demandetime = obj['demandetime'];
    this._demandetype = obj['demandetype'];
  }

  String get demandebudget => _demandebudget;
  String get demandedetails => _demandedetails;
  String get demandedate => _demandedate;
  String get demandetime => _demandetime;
  String get demandetype => _demandetype;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['demandebudget'] = _demandebudget;
    map['demandedetails'] = _demandedetails;
    map['demandedate'] = _demandedate;
    map['demandetime'] = _demandetime;
    map['demandetype'] = _demandetype;
    return map;
  }

  Demande.fromMap(Map<String, dynamic> map) {
    this._demandebudget = map['demandebudget'];
    this._demandedetails = map['demandedetails'];
    this._demandedate = map['demandedate'];
    this._demandetime = map['demandetime'];
    this._demandetype = map['demandetype'];
  }
}
