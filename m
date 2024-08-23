Return-Path: <linux-sctp+bounces-209-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC7E95C49C
	for <lists+linux-sctp@lfdr.de>; Fri, 23 Aug 2024 07:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E68D1F23E71
	for <lists+linux-sctp@lfdr.de>; Fri, 23 Aug 2024 05:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC4448CCD;
	Fri, 23 Aug 2024 05:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Z4ztqpq2"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C378493;
	Fri, 23 Aug 2024 05:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724389710; cv=none; b=Mzx6qGN1EDW2yFmxngv8GM9XGFl9IBcKsXZZU1jMnqkVdflsxH1IUQn8x+9QwDjWSdjT3wYPeSZSlDWXsk0g9QDcnVVfjqRl4Pi+mZ2BqjNKJ6JM52jqheJ5VswHudvcKSYRmeNj5d+7v3k4bwLFW4uQ419dwCtOE4Kbtj644/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724389710; c=relaxed/simple;
	bh=u41TN4fWsUuqEu+S8B7BBgs1qEp2OAxQEOHmP2i5vow=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QEa916GkqHN6PnD93LAaorCeQvCVGVLYsv/yQBB0tnz4vvMTWQ9ePqUIBJgxMa4t95YMvlZq+4DvDHF1nMV80XKxnSBNrvy2xKEFemy4xZLU6JQJekMehzy4z4/bjd5XzGcrEilLAbvvck20l6scStxNFgDRqQHcoEIpKUmZFAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Z4ztqpq2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47N0UYgP030649;
	Fri, 23 Aug 2024 05:08:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WdGvVpsXCRq9JxOvfcDfeqqfX4yOBVQw2SCwliCTMWE=; b=Z4ztqpq2w89F4Xz7
	kt7MuI4buGpyHxF7RxrvF6TplDYIPbPTXtbc45gtc9eGQEKAsYhrmH0XFGjY+O2e
	zqz19mp6YR70z9GeR0/1lzlATnLA+uIg+QVZnAkCehK020f01vXZjqje9dHK5ar0
	k1cNiOSNa7PRK3UavclX+ae+n4Hl68S1MkvpbkxWmnCBlzIzSTtLNrr1kUlo5FxT
	ta/CaPdBXEIp03IYj9E3u+3M1xUsT5l0KjnuoDPh/z47u30gG45P83Ls+4zb60w5
	UyA3BhTy9qOCSOuxGvpWNU16GzhIBZs9v8wudj4IwaDoCUrTYFGum1kHfxwp3/be
	xJolhQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 414pdmj2tk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 05:08:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47N5871i026948
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 05:08:07 GMT
Received: from [10.111.171.60] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 22 Aug
 2024 22:08:02 -0700
Message-ID: <7c977de1-fdfd-47c8-a117-5dd510849f57@quicinc.com>
Date: Thu, 22 Aug 2024 23:07:59 -0600
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 06/13] net: qualcomm: rmnet: Correct spelling in
 if_rmnet.h
To: Simon Horman <horms@kernel.org>,
        Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        "Paolo
 Abeni" <pabeni@redhat.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        "Thorsten Winkler" <twinkler@linux.ibm.com>,
        David Ahern
	<dsahern@kernel.org>, "Jay Vosburgh" <jv@jvosburgh.net>,
        Andy Gospodarek
	<andy@greyhouse.net>,
        "Sean Tranchetti" <quic_stranche@quicinc.com>,
        Paul
 Moore <paul@paul-moore.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jamal
 Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>, Jiri
 Pirko <jiri@resnulli.us>,
        "Marcelo Ricardo Leitner"
	<marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>, Martin Schiller
	<ms@dev.tdt.de>
CC: <netdev@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>, <linux-sctp@vger.kernel.org>,
        <linux-x25@vger.kernel.org>
References: <20240822-net-spell-v1-0-3a98971ce2d2@kernel.org>
 <20240822-net-spell-v1-6-3a98971ce2d2@kernel.org>
Content-Language: en-US
From: "Subash Abhinov Kasiviswanathan (KS)" <quic_subashab@quicinc.com>
In-Reply-To: <20240822-net-spell-v1-6-3a98971ce2d2@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nxn1AxiIUR23V32pf7IK2RKtu1Ne5L5l
X-Proofpoint-ORIG-GUID: nxn1AxiIUR23V32pf7IK2RKtu1Ne5L5l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_02,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501 mlxscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408230034


On 8/22/2024 6:57 AM, Simon Horman wrote:
> Correct spelling in if_rmnet.h
> As reported by codespell.
> 
> Cc: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>
> Cc: Sean Tranchetti <quic_stranche@quicinc.com>
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>   include/linux/if_rmnet.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/if_rmnet.h b/include/linux/if_rmnet.h
> index 839d1e48b85e..c44bf6e80ecb 100644
> --- a/include/linux/if_rmnet.h
> +++ b/include/linux/if_rmnet.h
> @@ -42,7 +42,7 @@ struct rmnet_map_ul_csum_header {
>   
>   /* csum_info field:
>    *  OFFSET:	where (offset in bytes) to insert computed checksum
> - *  UDP:	1 = UDP checksum (zero checkum means no checksum)
> + *  UDP:	1 = UDP checksum (zero checksum means no checksum)
>    *  ENABLED:	1 = checksum computation requested
>    */
>   #define MAP_CSUM_UL_OFFSET_MASK		GENMASK(13, 0)
> 

Reviewed-by: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>

