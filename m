Return-Path: <linux-sctp+bounces-150-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9D38BA562
	for <lists+linux-sctp@lfdr.de>; Fri,  3 May 2024 04:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FE7A1F22D3A
	for <lists+linux-sctp@lfdr.de>; Fri,  3 May 2024 02:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344AC17547;
	Fri,  3 May 2024 02:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O5V8oNYO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qBbDZrg7"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8E814F62;
	Fri,  3 May 2024 02:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714703359; cv=fail; b=fG0tr3Gq8H8ePprKaHbET4PbJqZPP6spBIm4YEFt9/mbo88iTqKV69YshgHrnSgfISLzVoi1sQbouxSgkbPztpXtKGa1VbGH8DXbrITrsbRqcGUI28ohNUVo+tSZsa1hrFGSeIKpmMSJeFZ4TNuX/rm6dVgqZXwj+UWWnfetqi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714703359; c=relaxed/simple;
	bh=V8IUdpt6zxg8N9huTRlB0oNtSOanrzgmh0wYfJSDgaQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZClHEBkzK5hpo0DI57jD6LdCNGMO+hM9RVuZoPwZ06iJCUdTlvSqPy+lWc3umuFP79vuke/qWH/TTewiks2SJBstj+zfKFT3peVu1X9N0SuduNuRdNsczhK3zbpYLA1dk9owf9Z9v67u1XC/P6F+lak+GkvbIUES5TvDr3VTgAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O5V8oNYO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qBbDZrg7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 442MY1dB026947;
	Fri, 3 May 2024 02:27:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=V8IUdpt6zxg8N9huTRlB0oNtSOanrzgmh0wYfJSDgaQ=;
 b=O5V8oNYOGJB//yrFcsI9oxQmOG9wsLNvvTg7i4YvoSgShUhFlHwMJ6gUHzkXsPEdgwzf
 XxxcLqCSGqF9vcb98osTSJZfFlI9icDz5wG/m6oTHwpi4Uv7jzA/EjI4awDDPKEqGiWO
 hN/RwGjFFgSv7l8TJq4m7goY9ivnjhQW7qJWXtra0aMQHYwmEz18BQmtR6QjJ3VBCBq2
 kLd+HX3dGlzb8Y5SGFLaCwFNVoT6Ek9f/eHRwoVRrKtUg8Fyv/2qckCanyx2Nl6ofybC
 7fZSobBnRbMLtWEk+t3OagqRTvpidnJz7dk9wX75z8e9EEg6rn5dlKwcYMfIGYAtWbWB IQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrr54qpph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 May 2024 02:27:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 442NBVWU002208;
	Fri, 3 May 2024 02:27:27 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqthrn1t-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 May 2024 02:27:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMwEpK5fbRDu7iYYocQN8TWMKl19SyMIcCFPOUBOlY7ydjPyv6R9e6uxVocgXx39qZuH6yqdA6g9pI+sp9hO/FI4EEhgcRfkBCKAx6nYI6xH8Wd8ecRhSs+lGIHdP3g4DAQ0/DRnj64m/LuT7ie/mioJ2lIVpi6g7KjpzxnANch7fOjVFYI6sbEUDdz3VW5wY4eCgfGnJBzS/ahC9mjqPM5iyE8jJAHTNbxeTHnRIdGnjyURJa2WYy7zilnOthmKhk6FPUSoAn1rf6VpXsRDe9okbadS96bps/nKCHQTIzV9e3AhjdM3BhiaunT/yFq9lX3e9/IxGnqlcqS30J5tTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8IUdpt6zxg8N9huTRlB0oNtSOanrzgmh0wYfJSDgaQ=;
 b=KgCF0rjMwXZWD9D31WLo+qlYc7NaDgwAOCkfgY+32lP7URXG0u0G8z1YdixEvExRq4uGg+z61PC8z04lEve7zSc1CzgubdnbAy2eFAElcF1UR+7QJh/eeALiYSOnHK50AfM009AYQiWpDm+uQH3uBlm5agUE6wJQXAo2B4EB+/HCCh4S5T8lPqf+mubgtmTpCyMaBGIXTjEd4gBSL0jhWVsSYdDfF2d3l1tYHYpeXe7OT6V4d05gD2Wsuxq2ynTqvuZdEr4HgDZm8n2A5NX4RSIbHMkNXrP1UVGHBIniyUcH7d/YY14VK9d9PFL2dXLBP0M8AMQ/tNoDKN8Kihejdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8IUdpt6zxg8N9huTRlB0oNtSOanrzgmh0wYfJSDgaQ=;
 b=qBbDZrg7iGWij3KwBgSFZYNQ9H7jPDfws+vgCxjF0T2bKp5eiUoXwDHe8DOyYH59hZO0M3MIyvIWu7VLIPQKwC+4HGU4OhI6DVN9UYsL4bQgOLHS6WQrLjJiBzKiuDpV8c3FS3krUAFGXbuB54g0+lOEN2aqmHbhnCRcfIKLbiE=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by BN0PR10MB4904.namprd10.prod.outlook.com (2603:10b6:408:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 02:27:23 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%3]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 02:27:22 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "kadlec@netfilter.org" <kadlec@netfilter.org>,
        "dsahern@kernel.org"
	<dsahern@kernel.org>,
        "tonylu@linux.alibaba.com" <tonylu@linux.alibaba.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>, "fw@strlen.de" <fw@strlen.de>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "matttbe@kernel.org"
	<matttbe@kernel.org>,
        "anna@kernel.org" <anna@kernel.org>,
        "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>,
        "tom@talpey.com" <tom@talpey.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "ms@dev.tdt.de" <ms@dev.tdt.de>,
        "stefan@datenfreihafen.org"
	<stefan@datenfreihafen.org>,
        "lucien.xin@gmail.com" <lucien.xin@gmail.com>,
        "ying.xue@windriver.com" <ying.xue@windriver.com>,
        "steffen.klassert@secunet.com" <steffen.klassert@secunet.com>,
        "marc.dionne@auristor.com" <marc.dionne@auristor.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "geliang@kernel.org" <geliang@kernel.org>,
        "ralf@linux-mips.org"
	<ralf@linux-mips.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "kuba@kernel.org" <kuba@kernel.org>, Dai Ngo <dai.ngo@oracle.com>,
        "jmaloy@redhat.com" <jmaloy@redhat.com>,
        "alex.aring@gmail.com"
	<alex.aring@gmail.com>,
        "ja@ssi.bg" <ja@ssi.bg>, "pablo@netfilter.org"
	<pablo@netfilter.org>,
        "horms@verge.net.au" <horms@verge.net.au>,
        "j.granados@samsung.com" <j.granados@samsung.com>,
        "kolga@netapp.com"
	<kolga@netapp.com>,
        "courmisch@gmail.com" <courmisch@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "martineau@kernel.org"
	<martineau@kernel.org>,
        "roopa@nvidia.com" <roopa@nvidia.com>,
        "wenjia@linux.ibm.com" <wenjia@linux.ibm.com>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "razor@blackwall.org" <razor@blackwall.org>,
        "jaka@linux.ibm.com" <jaka@linux.ibm.com>,
        "jreuter@yaina.de"
	<jreuter@yaina.de>,
        "guwen@linux.alibaba.com" <guwen@linux.alibaba.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "jlayton@kernel.org"
	<jlayton@kernel.org>,
        "marcelo.leitner@gmail.com"
	<marcelo.leitner@gmail.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
        "neilb@suse.de" <neilb@suse.de>,
        "alibuda@linux.alibaba.com"
	<alibuda@linux.alibaba.com>
CC: "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>,
        "bridge@lists.linux.dev"
	<bridge@lists.linux.dev>,
        "rds-devel@oss.oracle.com"
	<rds-devel@oss.oracle.com>,
        "netfilter-devel@vger.kernel.org"
	<netfilter-devel@vger.kernel.org>,
        "linux-sctp@vger.kernel.org"
	<linux-sctp@vger.kernel.org>,
        "dccp@vger.kernel.org" <dccp@vger.kernel.org>,
        "coreteam@netfilter.org" <coreteam@netfilter.org>,
        "linux-hams@vger.kernel.org" <linux-hams@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-x25@vger.kernel.org" <linux-x25@vger.kernel.org>,
        "lvs-devel@vger.kernel.org" <lvs-devel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>,
        "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>
Subject: Re: [PATCH net-next v6 3/8] net: rds: Remove the now superfluous
 sentinel elements from ctl_table array
Thread-Topic: [PATCH net-next v6 3/8] net: rds: Remove the now superfluous
 sentinel elements from ctl_table array
Thread-Index: AQHam6ouyPtShHQUv02+h6eEJdRkNbGEy4WA
Date: Fri, 3 May 2024 02:27:22 +0000
Message-ID: <4a2154ccbf8e0e73f09e717d49864eb1003d5cfa.camel@oracle.com>
References: <20240501-jag-sysctl_remset_net-v6-0-370b702b6b4a@samsung.com>
	 <20240501-jag-sysctl_remset_net-v6-3-370b702b6b4a@samsung.com>
In-Reply-To: <20240501-jag-sysctl_remset_net-v6-3-370b702b6b4a@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|BN0PR10MB4904:EE_
x-ms-office365-filtering-correlation-id: 8a4f4808-d177-47b3-bca1-08dc6b189012
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|1800799015|7416005|376005|366007|38070700009|921011;
x-microsoft-antispam-message-info: 
 =?utf-8?B?d3J4ZVRZY2Y1ampndUJzK3BHQ0ZrbExZUTJnUjJkMjRNVGFEdjhkdmV1VDVG?=
 =?utf-8?B?QVcyS3kvYllyWFY2Szh4WVJ3WmVqUmZtU3BXOGdrKzBrZnEyenFIZ0Zza0xU?=
 =?utf-8?B?UnZnS3o5Ri8zTCtDeDhNVEs2UThYZ1psQU55azlOYVJUcG5HdDVjc3I3T0Rp?=
 =?utf-8?B?TU5qeGVPYU4rYm8yclVibG84b28xbG9OQk1hUTNJZHNBSjFzTnNKckxGWFN1?=
 =?utf-8?B?bjZwQklIZlozdUV6VjBQWS9BWTZGc3ZuaEEweUVIQUE3dm5XNTh2YW1yN1BP?=
 =?utf-8?B?Y3g4SlA0ekEzU3JvZGc4dFc5eDhVTmZyRG1qUUJLdHI3RE5DVmErQWkxNVdt?=
 =?utf-8?B?NUhJaTMzc281eE16M0V0ZC9yb0NpU0ZjNkZISEFETU85SGMzck5uQXFFVWJp?=
 =?utf-8?B?Mk9vK2l1V1FWYVVuZmphc0VPUWQ5U0xUNlJTZ0FVU2ljbUhNd3pnZ2QwUi90?=
 =?utf-8?B?Vm5uSlA1dFNLUG5GUlZHV0ZNNGtYS2hsbjVHbVlBckJjVENGb2R3VEdYYVNW?=
 =?utf-8?B?WHFxUDFJeEs3WWxXdE9sV21Da1lvWmxncWYzVmRoWFZTYmVrcEpoNm1pNHQ1?=
 =?utf-8?B?Ykg3OE5EVm5vTnV5TTlaL2U2TVBIeHNzMW05bS9IeTR3cCtlRTB1aE5QZ1gv?=
 =?utf-8?B?bTU4U2xZRzFuTEJXdUVPSWhINW1GOS9ROVZLOU04OGVrTFI3UEZOUUxaRlRW?=
 =?utf-8?B?NGVzVGtzRGFPMTBYNC9KR1JZdmZyTXdSb3VDc3kzUHVnUGVGMFg4MmR3clI2?=
 =?utf-8?B?ZjhrMllKZVdoTll3VGtZa0t0YWlJWXdyK01lM0ZVd1lURGo2cGhVSWl4dkNG?=
 =?utf-8?B?YjhOQVNVWTc1TlVKa05QMFlNSjVONUg3WFkrRm5UTk1aTmpTc0YrU2IydUwz?=
 =?utf-8?B?c2E5a3krZHJzdjFlOFZ5ZkRCZXk4QUk0eUI5Q0xpblk1QTgzVG5VN2FqOExT?=
 =?utf-8?B?bjllRE9aRUxTUWhvVGtsdjlpN1JocVpVOTg2UGxEVVo1djNoSGZ1VXlpM2VL?=
 =?utf-8?B?QkJQQWNWb0lORmhHL1hWV1puVllCOTZEcW9iUXphalp4aGZXaWQ5MjgzcU4v?=
 =?utf-8?B?cnZBQUJiNmQycWhwamVsdk5XZ1QyVkNsSkd3cDh2WTBEVXlOd3lBS3NnWm43?=
 =?utf-8?B?b1Rjc3VRNWo3bTkyU3BRMFUrZFBaUzlPcVlrS1lYbmpHSm45VW1CZ2FKeXU5?=
 =?utf-8?B?alF5N2JPQklXTk85VHNiRWhGWXI1cVplZWlWMmI0SDhPWnFWOFVJbmlyblFD?=
 =?utf-8?B?eUdyYnMvQmRxT1NRR2pOVmxCK0R2TEIySDlud2VhS1p6Z1NEb01UWDBkK1ZN?=
 =?utf-8?B?R2VCWUpNS3hYOXZmSk81SFZJRGg1Nk5WNHhMYmtsektoYmRUamtCTFdKUUxz?=
 =?utf-8?B?Wk4rWFBLSkZzWWtCQkgrM2M3aTRENEVYY3h6SCtHQUFiZm93TEErTEFNMDEz?=
 =?utf-8?B?YjZ2OEV6M2daZDlKMXdJdDhmcnM0WGlhMERsNWdWeEtSK0xzZjQ0WjRXVVNq?=
 =?utf-8?B?Zy9mMXZQM2tMSFJOa3A4QXFZeW9qS0p2TE1nWDY3QlZqS2REMkdGVjdTWVA4?=
 =?utf-8?B?QzRrS2N6VzhiNzhwbkQ0KzhHNDF2RFdBSjZVY0VkS1A0aUg4NThTNUhJQUY1?=
 =?utf-8?B?NUE5VGgxKzBRODcrZGJoL2t6b0lGUk10Z3Z5aEFtckxyWVFxWTVYOTV4M0Np?=
 =?utf-8?B?VlFZcXduc3ArVnlTaXRLTmV6eWp3UDIvaFMxYnlqNk91ai92UmVTaXRTRldy?=
 =?utf-8?Q?jHLobuMe7Dl4q6Yf4A=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ODdGTlZ1TDJ1Wm9GMVNZd3REMlRaNXRKY0dmc3ZWRlVCWWlnZERvNmtLb0x1?=
 =?utf-8?B?MGRHVlh4am04ck53cTdJN09QNVY5dlVKTkI0eFg0Q3pVVW1nZU5oWUJzUDhR?=
 =?utf-8?B?M3VidHhISjVkU0RTQVliSU5BYU1ZcWpHM2pVYStaUTQ2K1FFb3g1WjY3SHlQ?=
 =?utf-8?B?RUsvS1NxQjFlM2I0M0Fuc0FaOGt6UHUzNGxaR3g4Ui9SOUhKUWNwZzdCK09C?=
 =?utf-8?B?TDJ3WnU5Z3ZIc21mU0dVMnJYOVJYOUIyZmVyT1o2RGVwSTZldzZVd2ppSjN4?=
 =?utf-8?B?LzBtMmJXYkV5M05ieUcyNS94OVIyRmpSTFNxSHFWWHlHb1BBaDZZeW96UVFZ?=
 =?utf-8?B?cktOMm1pYXJGUG5sbjI0SkZpSVpTUWtHOWxmM2tkK2JpS0tSaFN6TVltZ0xO?=
 =?utf-8?B?UTdkUHRHaGpLT3dqQ25wKy96YjFxSEhhRzN3cG9rNDhna25lLzlGRGZrTlZB?=
 =?utf-8?B?a0cxSlR6aWZKeDdZd1R5OFE4Z0E0S3Y2M2JFclhxM3YxZjN2QnAvMUZCc2Ni?=
 =?utf-8?B?UW1FdnpPMDl4TEpSYUYvN3pUQWQvTGpoQU82Q1VTUVhENytyd2wwbi8zQ0tZ?=
 =?utf-8?B?blg2Z0N0V0U1US9SMHA1TFFZQVl3K1pJM2l5VXF2c2lKS0pnWEkwandMbENu?=
 =?utf-8?B?SlZpT1k2YUtPc2pTL2lsTWE2THVlYVUrVmZoSnp2c1E4ZGFxbUo5bjVPU3FT?=
 =?utf-8?B?b2xjdmxlL0I0RWhKVmwvcWJ5ZEZQWTNFVXk4dUJSY2pUa1NOdjJVYU5td3g5?=
 =?utf-8?B?R2t4L1dBa1ZUTEJkRXRpWFFTbnBmc0c3NFJWdVRjVVA4MlAwbDNIUEs0OEow?=
 =?utf-8?B?VmRUQjV1R0RrR01DcnYwQVlIbWg4SXNZMk45RldnMkorWlZRNlRGZzFxVXk0?=
 =?utf-8?B?NlY1Y21vNEM2Y0VUOTBadk5UR0FrRm84RDc2ajN3aU83cnJsU3ZnL3kzMGVk?=
 =?utf-8?B?QUJCRWNQMXo2R2xNVGxTV3dNRVc0OUVENTVORnBqbXo0RkEvYUZvL28xRjVJ?=
 =?utf-8?B?UUNvNjJTYjRsYmVpME5sUHZ2T3d1K0hjQUZ0MVl4UlowV3pwQTFrRXZOdjI0?=
 =?utf-8?B?Wk0ybEV1S0g3aDNmUUpxTEg1UVo2R3MrVy9EU3o5cjQyY3AwU3VvUTVwVjBL?=
 =?utf-8?B?alV0M2tLRDVkNDhDL2RHK25jNG83ZC9WdUNwVm1DQmxFckpvcS90cXArVmFk?=
 =?utf-8?B?UktnRjZEbU85dWVyaEdDMHQxTjMwWkJjVlBhakxJWWlMalhRdHhKd1lxVzR0?=
 =?utf-8?B?Y1Q0THlXb2l0dlljRlFJcm9VRGpqVVNXbGNvcDlxZlQzVURPcncyL2c2Tit6?=
 =?utf-8?B?UVM3T0EzSmk3TnVJZ0JMQ3JVUUFKcUltM1NidEl3TnNnT3Z4TlY1QmxZMGxr?=
 =?utf-8?B?R3FRTWtlUE9OL1ZRN0cvT2xCYU90cGIrdlNWL0haWk96Y3YwVTNWQktDWUJX?=
 =?utf-8?B?VndZRkJuS3RIcUpRSzI3TFhJajdndi85Z0dIREVTQ2c2UHJOTUt5RnRBYlE5?=
 =?utf-8?B?cmZiY05MNHVzekI4Q0k3bHNhekN5UXZvdkRWZWliN1lVa1d5QzdsTW5lY1lq?=
 =?utf-8?B?QnQ2UVVydUVEb2gzZHFhNHR1QkZXcE51ZEQwdEtCSHRIYSsvWnF2amVTc0di?=
 =?utf-8?B?a0hvQmlWc0lLU1RpdVM1T0R1RVhHQThkZE5qaWdLdGMrWXZoaUZlQzlBU0s1?=
 =?utf-8?B?bnJ3eERqMnlwWXQvcDBSZVY0NGlGT0xmNGtvdVF1NStrQlkwRGtHQUVkRldE?=
 =?utf-8?B?MElMUy9ucDZUWGVEVFdneWhIVld2WXFHT1RmZE9ZektFL1ArN2JyQzlHVzRs?=
 =?utf-8?B?dEo4Zk9CQ1ZTTlBIbTFtVDJIaGdGem1pZGJ0ekRoeWszLy9HZkhJQ2pZeGk5?=
 =?utf-8?B?VkI3NlluZElYWTdhZlgzL3BKV1MxRVpLTGQrMjJyN1A4dm1uWi9tSTZKbDJD?=
 =?utf-8?B?Rk8zU3BWWXh3NGJZMVQ2dlVHd3FrS0swTkxoWnZnU21GZEEzR2gzMmt2dVFV?=
 =?utf-8?B?bnpoWkZhRDRRQVo0U0h5Q3JQOGk4b3lST1pYbmlFeXAzWTdheDErNTA1d05a?=
 =?utf-8?B?MU5hR3RUWFFiLzNSbUtHSFVHTDdvWXJtRmZ6TzhCc3RVdVFEVmFMa2JpbTl0?=
 =?utf-8?B?M2ZydC9lM1lxbHI0K0kxSk5SVWFlRU1ZYXFtR21Sc0kyeDJ4RnBWcU84dU43?=
 =?utf-8?B?ekE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <890B7E067F3C374998E04E6A1F84CD9A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Rk6/DUblOQUyogSXSfEAAhAdGtLm8yKGZtCPzx9DNeHxgc8xUp/xBmX2bCz1UVVxeSjgdN67Zz2opCXZwgaGEoFMFL7Pqo+AT341/FHIC4e4EZNh3j7XHSXy7zkpxRV1c26CCJQMPVPFWKgtCj1SCJ3fsNjiBAdgfiaXNSDXPoT253iVeQxnAxEkUDjBxjSRV7SQQw11xaz2BHJ8b77h/JU7/ORMZ7qje738ENu0MTwZ0A0LIRTK9fPSWBu091zAqZmYbh6nYq0h4h3zCTh3C50ohm807pOCqrtWE4dEu2V4uPi+mkmUUEG/d3958dI5XPO+YwTlKzGydulhGAY4wpjoDf9XHTfOi0o5O164WrLOagR4v9x6iwASP+CvG++JBhZngbz7+qgLPFzQT7IUy+NzlRoCCVFn8y3JhGv1Y/Xw9eKK0b9HcnlziEshX5pNrNHnO4+TwT0R5OsYGHWjX3VEh+HtpO+hU6ltDfrT0SSLDPUVpJ6HjdoaK/Xews/e3YF1rcyO2XfaFAZ92xnTHY4O2X+HPB+wf+lR48NADIqL7HRtRtzrBVX+DOdfpaEXzawROUXjkHWk/LLzNm7nOWVUfg5iZZoHXQe4QZW6EmM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4f4808-d177-47b3-bca1-08dc6b189012
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2024 02:27:22.0201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lsBw3leQXgvw/Z+OLCENnzgku7Y4+uUP/itjNPKtNDmQc8xZlsvruh/CeuYvMfUZhCmCgOKTFMJ7Xi0ZsJcODjzBQzjr9BdSwyyGpHsno7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4904
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_01,2024-05-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405030015
X-Proofpoint-ORIG-GUID: G62Cd-_EFC7smpzBwiexTuomHzDBd1br
X-Proofpoint-GUID: G62Cd-_EFC7smpzBwiexTuomHzDBd1br

T24gV2VkLCAyMDI0LTA1LTAxIGF0IDExOjI5ICswMjAwLCBKb2VsIEdyYW5hZG9zIHZpYSBCNCBS
ZWxheSB3cm90ZToKPiBGcm9tOiBKb2VsIEdyYW5hZG9zIDxqLmdyYW5hZG9zQHNhbXN1bmcuY29t
Pgo+IAo+IFRoaXMgY29tbWl0IGNvbWVzIGF0IHRoZSB0YWlsIGVuZCBvZiBhIGdyZWF0ZXIgZWZm
b3J0IHRvIHJlbW92ZSB0aGUKPiBlbXB0eSBlbGVtZW50cyBhdCB0aGUgZW5kIG9mIHRoZSBjdGxf
dGFibGUgYXJyYXlzIChzZW50aW5lbHMpIHdoaWNoCj4gd2lsbCByZWR1Y2UgdGhlIG92ZXJhbGwg
YnVpbGQgdGltZSBzaXplIG9mIHRoZSBrZXJuZWwgYW5kIHJ1biB0aW1lCj4gbWVtb3J5IGJsb2F0
IGJ5IH42NCBieXRlcyBwZXIgc2VudGluZWwgKGZ1cnRoZXIgaW5mb3JtYXRpb24gTGluayA6Cj4g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL1pPNVl4NUpGb2dHaSUyRmNCb0Bib21iYWRpbC5p
bmZyYWRlYWQub3JnLwo+ICkKPiAKPiAqIFJlbW92ZSBzZW50aW5lbCBlbGVtZW50IGZyb20gY3Rs
X3RhYmxlIHN0cnVjdHMuCj4gCj4gU2lnbmVkLW9mZi1ieTogSm9lbCBHcmFuYWRvcyA8ai5ncmFu
YWRvc0BzYW1zdW5nLmNvbT4KVGhlc2UgY2hhbmdlcyBsb29rIGZpbmUgdG8gbWUuICBUaGFuayB5
b3UhCkFja2VkLWJ5OiBBbGxpc29uIEhlbmRlcnNvbiA8YWxsaXNvbi5oZW5kZXJzb25Ab3JhY2xl
LmNvbT4KCj4gLS0tCj4gwqBuZXQvcmRzL2liX3N5c2N0bC5jIHwgMSAtCj4gwqBuZXQvcmRzL3N5
c2N0bC5jwqDCoMKgIHwgMSAtCj4gwqBuZXQvcmRzL3RjcC5jwqDCoMKgwqDCoMKgIHwgMSAtCj4g
wqAzIGZpbGVzIGNoYW5nZWQsIDMgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL25ldC9y
ZHMvaWJfc3lzY3RsLmMgYi9uZXQvcmRzL2liX3N5c2N0bC5jCj4gaW5kZXggZTRlNDFiM2FmY2U3
Li4yYWY2NzhlNzFlM2MgMTAwNjQ0Cj4gLS0tIGEvbmV0L3Jkcy9pYl9zeXNjdGwuYwo+ICsrKyBi
L25ldC9yZHMvaWJfc3lzY3RsLmMKPiBAQCAtMTAzLDcgKzEwMyw2IEBAIHN0YXRpYyBzdHJ1Y3Qg
Y3RsX3RhYmxlIHJkc19pYl9zeXNjdGxfdGFibGVbXSA9IHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoC5tb2RlwqDCoMKgwqDCoMKgwqDCoMKgwqDCoD0gMDY0NCwKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5wcm9jX2hhbmRsZXLCoMKgwqA9IHByb2NfZG9pbnR2
ZWMsCj4gwqDCoMKgwqDCoMKgwqDCoH0sCj4gLcKgwqDCoMKgwqDCoMKgeyB9Cj4gwqB9Owo+IMKg
Cj4gwqB2b2lkIHJkc19pYl9zeXNjdGxfZXhpdCh2b2lkKQo+IGRpZmYgLS1naXQgYS9uZXQvcmRz
L3N5c2N0bC5jIGIvbmV0L3Jkcy9zeXNjdGwuYwo+IGluZGV4IGUzODFiYmNkOWNjMS4uMDI1ZjUx
OGE0MzQ5IDEwMDY0NAo+IC0tLSBhL25ldC9yZHMvc3lzY3RsLmMKPiArKysgYi9uZXQvcmRzL3N5
c2N0bC5jCj4gQEAgLTg5LDcgKzg5LDYgQEAgc3RhdGljIHN0cnVjdCBjdGxfdGFibGUgcmRzX3N5
c2N0bF9yZHNfdGFibGVbXSA9IHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5t
b2RlwqDCoMKgwqDCoMKgwqDCoMKgwqAgPSAwNjQ0LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgLnByb2NfaGFuZGxlcsKgwqAgPSBwcm9jX2RvaW50dmVjLAo+IMKgwqDCoMKgwqDC
oMKgwqB9LAo+IC3CoMKgwqDCoMKgwqDCoHsgfQo+IMKgfTsKPiDCoAo+IMKgdm9pZCByZHNfc3lz
Y3RsX2V4aXQodm9pZCkKPiBkaWZmIC0tZ2l0IGEvbmV0L3Jkcy90Y3AuYyBiL25ldC9yZHMvdGNw
LmMKPiBpbmRleCAyZGJhNzUwNWI0MTQuLmQ4MTExYWM4M2JiNiAxMDA2NDQKPiAtLS0gYS9uZXQv
cmRzL3RjcC5jCj4gKysrIGIvbmV0L3Jkcy90Y3AuYwo+IEBAIC04Niw3ICs4Niw2IEBAIHN0YXRp
YyBzdHJ1Y3QgY3RsX3RhYmxlIHJkc190Y3Bfc3lzY3RsX3RhYmxlW10gPSB7Cj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAucHJvY19oYW5kbGVywqDCoCA9IHJkc190Y3Bfc2tidWZf
aGFuZGxlciwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5leHRyYTHCoMKgwqDC
oMKgwqDCoMKgwqA9ICZyZHNfdGNwX21pbl9yY3ZidWYsCj4gwqDCoMKgwqDCoMKgwqDCoH0sCj4g
LcKgwqDCoMKgwqDCoMKgeyB9Cj4gwqB9Owo+IMKgCj4gwqB1MzIgcmRzX3RjcF93cml0ZV9zZXEo
c3RydWN0IHJkc190Y3BfY29ubmVjdGlvbiAqdGMpCj4gCgo=

