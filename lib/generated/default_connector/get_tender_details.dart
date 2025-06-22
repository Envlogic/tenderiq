part of 'default.dart';

class GetTenderDetailsVariablesBuilder {
  String tenderId;
  Optional<int> _docLimit = Optional.optional(nativeFromJson, nativeToJson);
  Optional<int> _docOffset = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  GetTenderDetailsVariablesBuilder docLimit(int? t) {
   _docLimit.value = t;
   return this;
  }
  GetTenderDetailsVariablesBuilder docOffset(int? t) {
   _docOffset.value = t;
   return this;
  }

  GetTenderDetailsVariablesBuilder(this._dataConnect, {required  this.tenderId,});
  Deserializer<GetTenderDetailsData> dataDeserializer = (dynamic json)  => GetTenderDetailsData.fromJson(jsonDecode(json));
  Serializer<GetTenderDetailsVariables> varsSerializer = (GetTenderDetailsVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetTenderDetailsData, GetTenderDetailsVariables>> execute() {
    return ref().execute();
  }

  QueryRef<GetTenderDetailsData, GetTenderDetailsVariables> ref() {
    GetTenderDetailsVariables vars= GetTenderDetailsVariables(tenderId: tenderId,docLimit: _docLimit,docOffset: _docOffset,);
    return _dataConnect.query("GetTenderDetails", dataDeserializer, varsSerializer, vars);
  }
}

class GetTenderDetailsTender {
  String id;
  List<String>? tags;
  String? location;
  Timestamp? openingDate;
  Timestamp? closingDate;
  double? tenderAmount;
  String? tenderType;
  String? officialPortalUrl;
  GetTenderDetailsTenderAiRecommendation? aiRecommendation;
  GetTenderDetailsTenderRiskAlertFlag? riskAlertFlag;
  GetTenderDetailsTenderOrganization organization;
  String? tenderRefNo;
  GetTenderDetailsTenderBasicDetail? basicDetail;
  GetTenderDetailsTenderAuthority? authority;
  GetTenderDetailsTenderEmdFeeDetail? emdFeeDetail;
  GetTenderDetailsTenderWorkItemDetail? workItemDetail;
  GetTenderDetailsTenderCriticalDate? criticalDate;
  GetTenderDetailsTenderFinancialRequirement? financialRequirement;
  GetTenderDetailsTenderEligibilityCriterion? eligibilityCriterion;
  GetTenderDetailsTenderSubmissionInstruction? submissionInstruction;
  GetTenderDetailsTenderEvaluationProcess? evaluationProcess;
  GetTenderDetailsTenderLegalTerms? legalTerms;
  GetTenderDetailsTenderPostAwardTracking? postAwardTracking;
  GetTenderDetailsTender.fromJson(dynamic json):
  id = nativeFromJson<String>(json['id']),tags = json['tags'] == null ? null : (json['tags'] as List<dynamic>)
        .map((e) => nativeFromJson<String>(e))
        .toList(),location = json['location'] == null ? null : nativeFromJson<String>(json['location']),openingDate = json['openingDate'] == null ? null : Timestamp.fromJson(json['openingDate']),closingDate = json['closingDate'] == null ? null : Timestamp.fromJson(json['closingDate']),tenderAmount = json['tenderAmount'] == null ? null : nativeFromJson<double>(json['tenderAmount']),tenderType = json['tenderType'] == null ? null : nativeFromJson<String>(json['tenderType']),officialPortalUrl = json['officialPortalUrl'] == null ? null : nativeFromJson<String>(json['officialPortalUrl']),aiRecommendation = json['aiRecommendation'] == null ? null : GetTenderDetailsTenderAiRecommendation.fromJson(json['aiRecommendation']),riskAlertFlag = json['riskAlertFlag'] == null ? null : GetTenderDetailsTenderRiskAlertFlag.fromJson(json['riskAlertFlag']),organization = GetTenderDetailsTenderOrganization.fromJson(json['organization']),tenderRefNo = json['tenderRefNo'] == null ? null : nativeFromJson<String>(json['tenderRefNo']),basicDetail = json['basicDetail'] == null ? null : GetTenderDetailsTenderBasicDetail.fromJson(json['basicDetail']),authority = json['authority'] == null ? null : GetTenderDetailsTenderAuthority.fromJson(json['authority']),emdFeeDetail = json['emdFeeDetail'] == null ? null : GetTenderDetailsTenderEmdFeeDetail.fromJson(json['emdFeeDetail']),workItemDetail = json['workItemDetail'] == null ? null : GetTenderDetailsTenderWorkItemDetail.fromJson(json['workItemDetail']),criticalDate = json['criticalDate'] == null ? null : GetTenderDetailsTenderCriticalDate.fromJson(json['criticalDate']),financialRequirement = json['financialRequirement'] == null ? null : GetTenderDetailsTenderFinancialRequirement.fromJson(json['financialRequirement']),eligibilityCriterion = json['eligibilityCriterion'] == null ? null : GetTenderDetailsTenderEligibilityCriterion.fromJson(json['eligibilityCriterion']),submissionInstruction = json['submissionInstruction'] == null ? null : GetTenderDetailsTenderSubmissionInstruction.fromJson(json['submissionInstruction']),evaluationProcess = json['evaluationProcess'] == null ? null : GetTenderDetailsTenderEvaluationProcess.fromJson(json['evaluationProcess']),legalTerms = json['legalTerms'] == null ? null : GetTenderDetailsTenderLegalTerms.fromJson(json['legalTerms']),postAwardTracking = json['postAwardTracking'] == null ? null : GetTenderDetailsTenderPostAwardTracking.fromJson(json['postAwardTracking']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    if (tags != null) {
      json['tags'] = tags?.map((e) => nativeToJson<String>(e)).toList();
    }
    if (location != null) {
      json['location'] = nativeToJson<String?>(location);
    }
    if (openingDate != null) {
      json['openingDate'] = openingDate!.toJson();
    }
    if (closingDate != null) {
      json['closingDate'] = closingDate!.toJson();
    }
    if (tenderAmount != null) {
      json['tenderAmount'] = nativeToJson<double?>(tenderAmount);
    }
    if (tenderType != null) {
      json['tenderType'] = nativeToJson<String?>(tenderType);
    }
    if (officialPortalUrl != null) {
      json['officialPortalUrl'] = nativeToJson<String?>(officialPortalUrl);
    }
    if (aiRecommendation != null) {
      json['aiRecommendation'] = aiRecommendation!.toJson();
    }
    if (riskAlertFlag != null) {
      json['riskAlertFlag'] = riskAlertFlag!.toJson();
    }
    json['organization'] = organization.toJson();
    if (tenderRefNo != null) {
      json['tenderRefNo'] = nativeToJson<String?>(tenderRefNo);
    }
    if (basicDetail != null) {
      json['basicDetail'] = basicDetail!.toJson();
    }
    if (authority != null) {
      json['authority'] = authority!.toJson();
    }
    if (emdFeeDetail != null) {
      json['emdFeeDetail'] = emdFeeDetail!.toJson();
    }
    if (workItemDetail != null) {
      json['workItemDetail'] = workItemDetail!.toJson();
    }
    if (criticalDate != null) {
      json['criticalDate'] = criticalDate!.toJson();
    }
    if (financialRequirement != null) {
      json['financialRequirement'] = financialRequirement!.toJson();
    }
    if (eligibilityCriterion != null) {
      json['eligibilityCriterion'] = eligibilityCriterion!.toJson();
    }
    if (submissionInstruction != null) {
      json['submissionInstruction'] = submissionInstruction!.toJson();
    }
    if (evaluationProcess != null) {
      json['evaluationProcess'] = evaluationProcess!.toJson();
    }
    if (legalTerms != null) {
      json['legalTerms'] = legalTerms!.toJson();
    }
    if (postAwardTracking != null) {
      json['postAwardTracking'] = postAwardTracking!.toJson();
    }
    return json;
  }

  GetTenderDetailsTender({
    required this.id,
    this.tags,
    this.location,
    this.openingDate,
    this.closingDate,
    this.tenderAmount,
    this.tenderType,
    this.officialPortalUrl,
    this.aiRecommendation,
    this.riskAlertFlag,
    required this.organization,
    this.tenderRefNo,
    this.basicDetail,
    this.authority,
    this.emdFeeDetail,
    this.workItemDetail,
    this.criticalDate,
    this.financialRequirement,
    this.eligibilityCriterion,
    this.submissionInstruction,
    this.evaluationProcess,
    this.legalTerms,
    this.postAwardTracking,
  });
}

class GetTenderDetailsTenderAiRecommendation {
  double? fitScore;
  String? matchingCriteriaSummary;
  String? unmatchedCriteriaSummary;
  String? opportunityHighlights;
  GetTenderDetailsTenderAiRecommendation.fromJson(dynamic json):
  fitScore = json['fitScore'] == null ? null : nativeFromJson<double>(json['fitScore']),matchingCriteriaSummary = json['matchingCriteriaSummary'] == null ? null : nativeFromJson<String>(json['matchingCriteriaSummary']),unmatchedCriteriaSummary = json['unmatchedCriteriaSummary'] == null ? null : nativeFromJson<String>(json['unmatchedCriteriaSummary']),opportunityHighlights = json['opportunityHighlights'] == null ? null : nativeFromJson<String>(json['opportunityHighlights']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (fitScore != null) {
      json['fitScore'] = nativeToJson<double?>(fitScore);
    }
    if (matchingCriteriaSummary != null) {
      json['matchingCriteriaSummary'] = nativeToJson<String?>(matchingCriteriaSummary);
    }
    if (unmatchedCriteriaSummary != null) {
      json['unmatchedCriteriaSummary'] = nativeToJson<String?>(unmatchedCriteriaSummary);
    }
    if (opportunityHighlights != null) {
      json['opportunityHighlights'] = nativeToJson<String?>(opportunityHighlights);
    }
    return json;
  }

  GetTenderDetailsTenderAiRecommendation({
    this.fitScore,
    this.matchingCriteriaSummary,
    this.unmatchedCriteriaSummary,
    this.opportunityHighlights,
  });
}

class GetTenderDetailsTenderRiskAlertFlag {
  String? redFlags;
  String? orangeFlags;
  String? yellowFlags;
  GetTenderDetailsTenderRiskAlertFlag.fromJson(dynamic json):
  redFlags = json['redFlags'] == null ? null : nativeFromJson<String>(json['redFlags']),orangeFlags = json['orangeFlags'] == null ? null : nativeFromJson<String>(json['orangeFlags']),yellowFlags = json['yellowFlags'] == null ? null : nativeFromJson<String>(json['yellowFlags']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (redFlags != null) {
      json['redFlags'] = nativeToJson<String?>(redFlags);
    }
    if (orangeFlags != null) {
      json['orangeFlags'] = nativeToJson<String?>(orangeFlags);
    }
    if (yellowFlags != null) {
      json['yellowFlags'] = nativeToJson<String?>(yellowFlags);
    }
    return json;
  }

  GetTenderDetailsTenderRiskAlertFlag({
    this.redFlags,
    this.orangeFlags,
    this.yellowFlags,
  });
}

class GetTenderDetailsTenderOrganization {
  String name;
  GetTenderDetailsTenderOrganization.fromJson(dynamic json):
  name = nativeFromJson<String>(json['name']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    return json;
  }

  GetTenderDetailsTenderOrganization({
    required this.name,
  });
}

class GetTenderDetailsTenderBasicDetail {
  bool? withdrawalAllowed;
  String? formOfContract;
  int? noOfCovers;
  bool? generalEvalAllowed;
  String? paymentMode;
  bool? multiCurrencyFee;
  GetTenderDetailsTenderBasicDetail.fromJson(dynamic json):
  withdrawalAllowed = json['withdrawalAllowed'] == null ? null : nativeFromJson<bool>(json['withdrawalAllowed']),formOfContract = json['formOfContract'] == null ? null : nativeFromJson<String>(json['formOfContract']),noOfCovers = json['noOfCovers'] == null ? null : nativeFromJson<int>(json['noOfCovers']),generalEvalAllowed = json['generalEvalAllowed'] == null ? null : nativeFromJson<bool>(json['generalEvalAllowed']),paymentMode = json['paymentMode'] == null ? null : nativeFromJson<String>(json['paymentMode']),multiCurrencyFee = json['multiCurrencyFee'] == null ? null : nativeFromJson<bool>(json['multiCurrencyFee']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (withdrawalAllowed != null) {
      json['withdrawalAllowed'] = nativeToJson<bool?>(withdrawalAllowed);
    }
    if (formOfContract != null) {
      json['formOfContract'] = nativeToJson<String?>(formOfContract);
    }
    if (noOfCovers != null) {
      json['noOfCovers'] = nativeToJson<int?>(noOfCovers);
    }
    if (generalEvalAllowed != null) {
      json['generalEvalAllowed'] = nativeToJson<bool?>(generalEvalAllowed);
    }
    if (paymentMode != null) {
      json['paymentMode'] = nativeToJson<String?>(paymentMode);
    }
    if (multiCurrencyFee != null) {
      json['multiCurrencyFee'] = nativeToJson<bool?>(multiCurrencyFee);
    }
    return json;
  }

  GetTenderDetailsTenderBasicDetail({
    this.withdrawalAllowed,
    this.formOfContract,
    this.noOfCovers,
    this.generalEvalAllowed,
    this.paymentMode,
    this.multiCurrencyFee,
  });
}

class GetTenderDetailsTenderAuthority {
  String? name;
  String? address;
  GetTenderDetailsTenderAuthority.fromJson(dynamic json):
  name = json['name'] == null ? null : nativeFromJson<String>(json['name']),address = json['address'] == null ? null : nativeFromJson<String>(json['address']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (name != null) {
      json['name'] = nativeToJson<String?>(name);
    }
    if (address != null) {
      json['address'] = nativeToJson<String?>(address);
    }
    return json;
  }

  GetTenderDetailsTenderAuthority({
    this.name,
    this.address,
  });
}

class GetTenderDetailsTenderEmdFeeDetail {
  double? emdAmount;
  String? emdFeeType;
  String? emdPayableTo;
  String? emdPayableAt;
  GetTenderDetailsTenderEmdFeeDetail.fromJson(dynamic json):
  emdAmount = json['emdAmount'] == null ? null : nativeFromJson<double>(json['emdAmount']),emdFeeType = json['emdFeeType'] == null ? null : nativeFromJson<String>(json['emdFeeType']),emdPayableTo = json['emdPayableTo'] == null ? null : nativeFromJson<String>(json['emdPayableTo']),emdPayableAt = json['emdPayableAt'] == null ? null : nativeFromJson<String>(json['emdPayableAt']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (emdAmount != null) {
      json['emdAmount'] = nativeToJson<double?>(emdAmount);
    }
    if (emdFeeType != null) {
      json['emdFeeType'] = nativeToJson<String?>(emdFeeType);
    }
    if (emdPayableTo != null) {
      json['emdPayableTo'] = nativeToJson<String?>(emdPayableTo);
    }
    if (emdPayableAt != null) {
      json['emdPayableAt'] = nativeToJson<String?>(emdPayableAt);
    }
    return json;
  }

  GetTenderDetailsTenderEmdFeeDetail({
    this.emdAmount,
    this.emdFeeType,
    this.emdPayableTo,
    this.emdPayableAt,
  });
}

class GetTenderDetailsTenderWorkItemDetail {
  String? title;
  String? description;
  String? ndaPrequalification;
  String? remarks;
  double? tenderValue;
  String? productCategory;
  GetTenderDetailsTenderWorkItemDetail.fromJson(dynamic json):
  title = json['title'] == null ? null : nativeFromJson<String>(json['title']),description = json['description'] == null ? null : nativeFromJson<String>(json['description']),ndaPrequalification = json['ndaPrequalification'] == null ? null : nativeFromJson<String>(json['ndaPrequalification']),remarks = json['remarks'] == null ? null : nativeFromJson<String>(json['remarks']),tenderValue = json['tenderValue'] == null ? null : nativeFromJson<double>(json['tenderValue']),productCategory = json['productCategory'] == null ? null : nativeFromJson<String>(json['productCategory']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (title != null) {
      json['title'] = nativeToJson<String?>(title);
    }
    if (description != null) {
      json['description'] = nativeToJson<String?>(description);
    }
    if (ndaPrequalification != null) {
      json['ndaPrequalification'] = nativeToJson<String?>(ndaPrequalification);
    }
    if (remarks != null) {
      json['remarks'] = nativeToJson<String?>(remarks);
    }
    if (tenderValue != null) {
      json['tenderValue'] = nativeToJson<double?>(tenderValue);
    }
    if (productCategory != null) {
      json['productCategory'] = nativeToJson<String?>(productCategory);
    }
    return json;
  }

  GetTenderDetailsTenderWorkItemDetail({
    this.title,
    this.description,
    this.ndaPrequalification,
    this.remarks,
    this.tenderValue,
    this.productCategory,
  });
}

class GetTenderDetailsTenderCriticalDate {
  Timestamp? publishedDate;
  Timestamp? bidSubmissionStartDate;
  Timestamp? bidSubmissionEndDate;
  Timestamp? bidOpeningDate;
  GetTenderDetailsTenderCriticalDate.fromJson(dynamic json):
  publishedDate = json['publishedDate'] == null ? null : Timestamp.fromJson(json['publishedDate']),bidSubmissionStartDate = json['bidSubmissionStartDate'] == null ? null : Timestamp.fromJson(json['bidSubmissionStartDate']),bidSubmissionEndDate = json['bidSubmissionEndDate'] == null ? null : Timestamp.fromJson(json['bidSubmissionEndDate']),bidOpeningDate = json['bidOpeningDate'] == null ? null : Timestamp.fromJson(json['bidOpeningDate']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (publishedDate != null) {
      json['publishedDate'] = publishedDate!.toJson();
    }
    if (bidSubmissionStartDate != null) {
      json['bidSubmissionStartDate'] = bidSubmissionStartDate!.toJson();
    }
    if (bidSubmissionEndDate != null) {
      json['bidSubmissionEndDate'] = bidSubmissionEndDate!.toJson();
    }
    if (bidOpeningDate != null) {
      json['bidOpeningDate'] = bidOpeningDate!.toJson();
    }
    return json;
  }

  GetTenderDetailsTenderCriticalDate({
    this.publishedDate,
    this.bidSubmissionStartDate,
    this.bidSubmissionEndDate,
    this.bidOpeningDate,
  });
}

class GetTenderDetailsTenderFinancialRequirement {
  double? estimatedContractValue;
  double? costBaseScope;
  double? taxes;
  double? otherCharges;
  double? bidSecurityAmount;
  String? bidSecurityFormat;
  int? bidSecurityValidity;
  double? documentFeeAmount;
  String? documentFeeMode;
  double? performanceGuaranteePct;
  double? performanceGuaranteeValue;
  String? advancePaymentTerms;
  String? taxClauses;
  GetTenderDetailsTenderFinancialRequirement.fromJson(dynamic json):
  estimatedContractValue = json['estimatedContractValue'] == null ? null : nativeFromJson<double>(json['estimatedContractValue']),costBaseScope = json['costBaseScope'] == null ? null : nativeFromJson<double>(json['costBaseScope']),taxes = json['taxes'] == null ? null : nativeFromJson<double>(json['taxes']),otherCharges = json['otherCharges'] == null ? null : nativeFromJson<double>(json['otherCharges']),bidSecurityAmount = json['bidSecurityAmount'] == null ? null : nativeFromJson<double>(json['bidSecurityAmount']),bidSecurityFormat = json['bidSecurityFormat'] == null ? null : nativeFromJson<String>(json['bidSecurityFormat']),bidSecurityValidity = json['bidSecurityValidity'] == null ? null : nativeFromJson<int>(json['bidSecurityValidity']),documentFeeAmount = json['documentFeeAmount'] == null ? null : nativeFromJson<double>(json['documentFeeAmount']),documentFeeMode = json['documentFeeMode'] == null ? null : nativeFromJson<String>(json['documentFeeMode']),performanceGuaranteePct = json['performanceGuaranteePct'] == null ? null : nativeFromJson<double>(json['performanceGuaranteePct']),performanceGuaranteeValue = json['performanceGuaranteeValue'] == null ? null : nativeFromJson<double>(json['performanceGuaranteeValue']),advancePaymentTerms = json['advancePaymentTerms'] == null ? null : nativeFromJson<String>(json['advancePaymentTerms']),taxClauses = json['taxClauses'] == null ? null : nativeFromJson<String>(json['taxClauses']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (estimatedContractValue != null) {
      json['estimatedContractValue'] = nativeToJson<double?>(estimatedContractValue);
    }
    if (costBaseScope != null) {
      json['costBaseScope'] = nativeToJson<double?>(costBaseScope);
    }
    if (taxes != null) {
      json['taxes'] = nativeToJson<double?>(taxes);
    }
    if (otherCharges != null) {
      json['otherCharges'] = nativeToJson<double?>(otherCharges);
    }
    if (bidSecurityAmount != null) {
      json['bidSecurityAmount'] = nativeToJson<double?>(bidSecurityAmount);
    }
    if (bidSecurityFormat != null) {
      json['bidSecurityFormat'] = nativeToJson<String?>(bidSecurityFormat);
    }
    if (bidSecurityValidity != null) {
      json['bidSecurityValidity'] = nativeToJson<int?>(bidSecurityValidity);
    }
    if (documentFeeAmount != null) {
      json['documentFeeAmount'] = nativeToJson<double?>(documentFeeAmount);
    }
    if (documentFeeMode != null) {
      json['documentFeeMode'] = nativeToJson<String?>(documentFeeMode);
    }
    if (performanceGuaranteePct != null) {
      json['performanceGuaranteePct'] = nativeToJson<double?>(performanceGuaranteePct);
    }
    if (performanceGuaranteeValue != null) {
      json['performanceGuaranteeValue'] = nativeToJson<double?>(performanceGuaranteeValue);
    }
    if (advancePaymentTerms != null) {
      json['advancePaymentTerms'] = nativeToJson<String?>(advancePaymentTerms);
    }
    if (taxClauses != null) {
      json['taxClauses'] = nativeToJson<String?>(taxClauses);
    }
    return json;
  }

  GetTenderDetailsTenderFinancialRequirement({
    this.estimatedContractValue,
    this.costBaseScope,
    this.taxes,
    this.otherCharges,
    this.bidSecurityAmount,
    this.bidSecurityFormat,
    this.bidSecurityValidity,
    this.documentFeeAmount,
    this.documentFeeMode,
    this.performanceGuaranteePct,
    this.performanceGuaranteeValue,
    this.advancePaymentTerms,
    this.taxClauses,
  });
}

class GetTenderDetailsTenderEligibilityCriterion {
  double? minAnnualTurnover;
  int? yearsConsidered;
  int? similarContractsCount;
  double? minValuePerContract;
  String? similarWorkDefinition;
  String? volumeBenchmark;
  String? keyPersonnel;
  String? equipmentRequired;
  bool? siteVisitRequired;
  bool? jvAllowed;
  double? minJvShare;
  String? litigationBlacklistHistory;
  String? financialEvidence;
  GetTenderDetailsTenderEligibilityCriterion.fromJson(dynamic json):
  minAnnualTurnover = json['minAnnualTurnover'] == null ? null : nativeFromJson<double>(json['minAnnualTurnover']),yearsConsidered = json['yearsConsidered'] == null ? null : nativeFromJson<int>(json['yearsConsidered']),similarContractsCount = json['similarContractsCount'] == null ? null : nativeFromJson<int>(json['similarContractsCount']),minValuePerContract = json['minValuePerContract'] == null ? null : nativeFromJson<double>(json['minValuePerContract']),similarWorkDefinition = json['similarWorkDefinition'] == null ? null : nativeFromJson<String>(json['similarWorkDefinition']),volumeBenchmark = json['volumeBenchmark'] == null ? null : nativeFromJson<String>(json['volumeBenchmark']),keyPersonnel = json['keyPersonnel'] == null ? null : nativeFromJson<String>(json['keyPersonnel']),equipmentRequired = json['equipmentRequired'] == null ? null : nativeFromJson<String>(json['equipmentRequired']),siteVisitRequired = json['siteVisitRequired'] == null ? null : nativeFromJson<bool>(json['siteVisitRequired']),jvAllowed = json['jvAllowed'] == null ? null : nativeFromJson<bool>(json['jvAllowed']),minJvShare = json['minJvShare'] == null ? null : nativeFromJson<double>(json['minJvShare']),litigationBlacklistHistory = json['litigationBlacklistHistory'] == null ? null : nativeFromJson<String>(json['litigationBlacklistHistory']),financialEvidence = json['financialEvidence'] == null ? null : nativeFromJson<String>(json['financialEvidence']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (minAnnualTurnover != null) {
      json['minAnnualTurnover'] = nativeToJson<double?>(minAnnualTurnover);
    }
    if (yearsConsidered != null) {
      json['yearsConsidered'] = nativeToJson<int?>(yearsConsidered);
    }
    if (similarContractsCount != null) {
      json['similarContractsCount'] = nativeToJson<int?>(similarContractsCount);
    }
    if (minValuePerContract != null) {
      json['minValuePerContract'] = nativeToJson<double?>(minValuePerContract);
    }
    if (similarWorkDefinition != null) {
      json['similarWorkDefinition'] = nativeToJson<String?>(similarWorkDefinition);
    }
    if (volumeBenchmark != null) {
      json['volumeBenchmark'] = nativeToJson<String?>(volumeBenchmark);
    }
    if (keyPersonnel != null) {
      json['keyPersonnel'] = nativeToJson<String?>(keyPersonnel);
    }
    if (equipmentRequired != null) {
      json['equipmentRequired'] = nativeToJson<String?>(equipmentRequired);
    }
    if (siteVisitRequired != null) {
      json['siteVisitRequired'] = nativeToJson<bool?>(siteVisitRequired);
    }
    if (jvAllowed != null) {
      json['jvAllowed'] = nativeToJson<bool?>(jvAllowed);
    }
    if (minJvShare != null) {
      json['minJvShare'] = nativeToJson<double?>(minJvShare);
    }
    if (litigationBlacklistHistory != null) {
      json['litigationBlacklistHistory'] = nativeToJson<String?>(litigationBlacklistHistory);
    }
    if (financialEvidence != null) {
      json['financialEvidence'] = nativeToJson<String?>(financialEvidence);
    }
    return json;
  }

  GetTenderDetailsTenderEligibilityCriterion({
    this.minAnnualTurnover,
    this.yearsConsidered,
    this.similarContractsCount,
    this.minValuePerContract,
    this.similarWorkDefinition,
    this.volumeBenchmark,
    this.keyPersonnel,
    this.equipmentRequired,
    this.siteVisitRequired,
    this.jvAllowed,
    this.minJvShare,
    this.litigationBlacklistHistory,
    this.financialEvidence,
  });
}

class GetTenderDetailsTenderSubmissionInstruction {
  String? submissionMode;
  String? envelopeStructure;
  String? allowedFileFormats;
  bool? digitalSignatureRequired;
  String? physicalSubmissionAddress;
  int? copiesRequired;
  String? mandatoryChecklist;
  bool? virusCertificationRequired;
  GetTenderDetailsTenderSubmissionInstruction.fromJson(dynamic json):
  submissionMode = json['submissionMode'] == null ? null : nativeFromJson<String>(json['submissionMode']),envelopeStructure = json['envelopeStructure'] == null ? null : nativeFromJson<String>(json['envelopeStructure']),allowedFileFormats = json['allowedFileFormats'] == null ? null : nativeFromJson<String>(json['allowedFileFormats']),digitalSignatureRequired = json['digitalSignatureRequired'] == null ? null : nativeFromJson<bool>(json['digitalSignatureRequired']),physicalSubmissionAddress = json['physicalSubmissionAddress'] == null ? null : nativeFromJson<String>(json['physicalSubmissionAddress']),copiesRequired = json['copiesRequired'] == null ? null : nativeFromJson<int>(json['copiesRequired']),mandatoryChecklist = json['mandatoryChecklist'] == null ? null : nativeFromJson<String>(json['mandatoryChecklist']),virusCertificationRequired = json['virusCertificationRequired'] == null ? null : nativeFromJson<bool>(json['virusCertificationRequired']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (submissionMode != null) {
      json['submissionMode'] = nativeToJson<String?>(submissionMode);
    }
    if (envelopeStructure != null) {
      json['envelopeStructure'] = nativeToJson<String?>(envelopeStructure);
    }
    if (allowedFileFormats != null) {
      json['allowedFileFormats'] = nativeToJson<String?>(allowedFileFormats);
    }
    if (digitalSignatureRequired != null) {
      json['digitalSignatureRequired'] = nativeToJson<bool?>(digitalSignatureRequired);
    }
    if (physicalSubmissionAddress != null) {
      json['physicalSubmissionAddress'] = nativeToJson<String?>(physicalSubmissionAddress);
    }
    if (copiesRequired != null) {
      json['copiesRequired'] = nativeToJson<int?>(copiesRequired);
    }
    if (mandatoryChecklist != null) {
      json['mandatoryChecklist'] = nativeToJson<String?>(mandatoryChecklist);
    }
    if (virusCertificationRequired != null) {
      json['virusCertificationRequired'] = nativeToJson<bool?>(virusCertificationRequired);
    }
    return json;
  }

  GetTenderDetailsTenderSubmissionInstruction({
    this.submissionMode,
    this.envelopeStructure,
    this.allowedFileFormats,
    this.digitalSignatureRequired,
    this.physicalSubmissionAddress,
    this.copiesRequired,
    this.mandatoryChecklist,
    this.virusCertificationRequired,
  });
}

class GetTenderDetailsTenderEvaluationProcess {
  String? evaluationMethod;
  double? technicalWeightage;
  double? financialWeightage;
  String? responsivenessCriteria;
  String? arithmeticCorrectionRules;
  String? bidCapacityFormula;
  bool? negotiationAllowed;
  String? awardCriteria;
  String? notificationTimeline;
  GetTenderDetailsTenderEvaluationProcess.fromJson(dynamic json):
  evaluationMethod = json['evaluationMethod'] == null ? null : nativeFromJson<String>(json['evaluationMethod']),technicalWeightage = json['technicalWeightage'] == null ? null : nativeFromJson<double>(json['technicalWeightage']),financialWeightage = json['financialWeightage'] == null ? null : nativeFromJson<double>(json['financialWeightage']),responsivenessCriteria = json['responsivenessCriteria'] == null ? null : nativeFromJson<String>(json['responsivenessCriteria']),arithmeticCorrectionRules = json['arithmeticCorrectionRules'] == null ? null : nativeFromJson<String>(json['arithmeticCorrectionRules']),bidCapacityFormula = json['bidCapacityFormula'] == null ? null : nativeFromJson<String>(json['bidCapacityFormula']),negotiationAllowed = json['negotiationAllowed'] == null ? null : nativeFromJson<bool>(json['negotiationAllowed']),awardCriteria = json['awardCriteria'] == null ? null : nativeFromJson<String>(json['awardCriteria']),notificationTimeline = json['notificationTimeline'] == null ? null : nativeFromJson<String>(json['notificationTimeline']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (evaluationMethod != null) {
      json['evaluationMethod'] = nativeToJson<String?>(evaluationMethod);
    }
    if (technicalWeightage != null) {
      json['technicalWeightage'] = nativeToJson<double?>(technicalWeightage);
    }
    if (financialWeightage != null) {
      json['financialWeightage'] = nativeToJson<double?>(financialWeightage);
    }
    if (responsivenessCriteria != null) {
      json['responsivenessCriteria'] = nativeToJson<String?>(responsivenessCriteria);
    }
    if (arithmeticCorrectionRules != null) {
      json['arithmeticCorrectionRules'] = nativeToJson<String?>(arithmeticCorrectionRules);
    }
    if (bidCapacityFormula != null) {
      json['bidCapacityFormula'] = nativeToJson<String?>(bidCapacityFormula);
    }
    if (negotiationAllowed != null) {
      json['negotiationAllowed'] = nativeToJson<bool?>(negotiationAllowed);
    }
    if (awardCriteria != null) {
      json['awardCriteria'] = nativeToJson<String?>(awardCriteria);
    }
    if (notificationTimeline != null) {
      json['notificationTimeline'] = nativeToJson<String?>(notificationTimeline);
    }
    return json;
  }

  GetTenderDetailsTenderEvaluationProcess({
    this.evaluationMethod,
    this.technicalWeightage,
    this.financialWeightage,
    this.responsivenessCriteria,
    this.arithmeticCorrectionRules,
    this.bidCapacityFormula,
    this.negotiationAllowed,
    this.awardCriteria,
    this.notificationTimeline,
  });
}

class GetTenderDetailsTenderLegalTerms {
  String? formOfContract;
  String? performanceReleaseConditions;
  String? penaltyClauses;
  String? forfeitureConditions;
  String? forceMajeure;
  String? disputeResolution;
  String? antiCorruptionClause;
  String? terminationConditions;
  GetTenderDetailsTenderLegalTerms.fromJson(dynamic json):
  formOfContract = json['formOfContract'] == null ? null : nativeFromJson<String>(json['formOfContract']),performanceReleaseConditions = json['performanceReleaseConditions'] == null ? null : nativeFromJson<String>(json['performanceReleaseConditions']),penaltyClauses = json['penaltyClauses'] == null ? null : nativeFromJson<String>(json['penaltyClauses']),forfeitureConditions = json['forfeitureConditions'] == null ? null : nativeFromJson<String>(json['forfeitureConditions']),forceMajeure = json['forceMajeure'] == null ? null : nativeFromJson<String>(json['forceMajeure']),disputeResolution = json['disputeResolution'] == null ? null : nativeFromJson<String>(json['disputeResolution']),antiCorruptionClause = json['antiCorruptionClause'] == null ? null : nativeFromJson<String>(json['antiCorruptionClause']),terminationConditions = json['terminationConditions'] == null ? null : nativeFromJson<String>(json['terminationConditions']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (formOfContract != null) {
      json['formOfContract'] = nativeToJson<String?>(formOfContract);
    }
    if (performanceReleaseConditions != null) {
      json['performanceReleaseConditions'] = nativeToJson<String?>(performanceReleaseConditions);
    }
    if (penaltyClauses != null) {
      json['penaltyClauses'] = nativeToJson<String?>(penaltyClauses);
    }
    if (forfeitureConditions != null) {
      json['forfeitureConditions'] = nativeToJson<String?>(forfeitureConditions);
    }
    if (forceMajeure != null) {
      json['forceMajeure'] = nativeToJson<String?>(forceMajeure);
    }
    if (disputeResolution != null) {
      json['disputeResolution'] = nativeToJson<String?>(disputeResolution);
    }
    if (antiCorruptionClause != null) {
      json['antiCorruptionClause'] = nativeToJson<String?>(antiCorruptionClause);
    }
    if (terminationConditions != null) {
      json['terminationConditions'] = nativeToJson<String?>(terminationConditions);
    }
    return json;
  }

  GetTenderDetailsTenderLegalTerms({
    this.formOfContract,
    this.performanceReleaseConditions,
    this.penaltyClauses,
    this.forfeitureConditions,
    this.forceMajeure,
    this.disputeResolution,
    this.antiCorruptionClause,
    this.terminationConditions,
  });
}

class GetTenderDetailsTenderPostAwardTracking {
  String? advancePaymentSchedule;
  String? reportingFrequency;
  String? qualityTestingRequirements;
  String? paymentMilestones;
  int? warrantyPeriodDays;
  Timestamp? finalHandoverDate;
  GetTenderDetailsTenderPostAwardTracking.fromJson(dynamic json):
  advancePaymentSchedule = json['advancePaymentSchedule'] == null ? null : nativeFromJson<String>(json['advancePaymentSchedule']),reportingFrequency = json['reportingFrequency'] == null ? null : nativeFromJson<String>(json['reportingFrequency']),qualityTestingRequirements = json['qualityTestingRequirements'] == null ? null : nativeFromJson<String>(json['qualityTestingRequirements']),paymentMilestones = json['paymentMilestones'] == null ? null : nativeFromJson<String>(json['paymentMilestones']),warrantyPeriodDays = json['warrantyPeriodDays'] == null ? null : nativeFromJson<int>(json['warrantyPeriodDays']),finalHandoverDate = json['finalHandoverDate'] == null ? null : Timestamp.fromJson(json['finalHandoverDate']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (advancePaymentSchedule != null) {
      json['advancePaymentSchedule'] = nativeToJson<String?>(advancePaymentSchedule);
    }
    if (reportingFrequency != null) {
      json['reportingFrequency'] = nativeToJson<String?>(reportingFrequency);
    }
    if (qualityTestingRequirements != null) {
      json['qualityTestingRequirements'] = nativeToJson<String?>(qualityTestingRequirements);
    }
    if (paymentMilestones != null) {
      json['paymentMilestones'] = nativeToJson<String?>(paymentMilestones);
    }
    if (warrantyPeriodDays != null) {
      json['warrantyPeriodDays'] = nativeToJson<int?>(warrantyPeriodDays);
    }
    if (finalHandoverDate != null) {
      json['finalHandoverDate'] = finalHandoverDate!.toJson();
    }
    return json;
  }

  GetTenderDetailsTenderPostAwardTracking({
    this.advancePaymentSchedule,
    this.reportingFrequency,
    this.qualityTestingRequirements,
    this.paymentMilestones,
    this.warrantyPeriodDays,
    this.finalHandoverDate,
  });
}

class GetTenderDetailsData {
  GetTenderDetailsTender? tender;
  GetTenderDetailsData.fromJson(dynamic json):
  tender = json['tender'] == null ? null : GetTenderDetailsTender.fromJson(json['tender']);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (tender != null) {
      json['tender'] = tender!.toJson();
    }
    return json;
  }

  GetTenderDetailsData({
    this.tender,
  });
}

class GetTenderDetailsVariables {
  String tenderId;
  late Optional<int>docLimit;
  late Optional<int>docOffset;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetTenderDetailsVariables.fromJson(Map<String, dynamic> json):
  tenderId = nativeFromJson<String>(json['tenderId']) {
  
    docLimit = Optional.optional(nativeFromJson, nativeToJson);
    docLimit.value = json['docLimit'] == null ? null : nativeFromJson<int>(json['docLimit']);
  
    docOffset = Optional.optional(nativeFromJson, nativeToJson);
    docOffset.value = json['docOffset'] == null ? null : nativeFromJson<int>(json['docOffset']);
  
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['tenderId'] = nativeToJson<String>(tenderId);
    if(docLimit.state == OptionalState.set) {
      json['docLimit'] = docLimit.toJson();
    }
    if(docOffset.state == OptionalState.set) {
      json['docOffset'] = docOffset.toJson();
    }
    return json;
  }

  GetTenderDetailsVariables({
    required this.tenderId,
    required this.docLimit,
    required this.docOffset,
  });
}

