Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9395B01F3
	for <lists+linux-sctp@lfdr.de>; Wed,  7 Sep 2022 12:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiIGKcs (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 7 Sep 2022 06:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiIGKcr (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 7 Sep 2022 06:32:47 -0400
Received: from mx08-002d6701.pphosted.com (mx08-002d6701.pphosted.com [185.183.28.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A5C8304D
        for <linux-sctp@vger.kernel.org>; Wed,  7 Sep 2022 03:32:46 -0700 (PDT)
Received: from pps.filterd (m0132499.ppops.net [127.0.0.1])
        by mx08-002d6701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2872JAU4024298
        for <linux-sctp@vger.kernel.org>; Wed, 7 Sep 2022 10:32:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flex.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=dkim; bh=UFuD2Q+M005Dr5HMIITGuhq1Els4oPPnukq9H3cyXGQ=;
 b=No+7/c4u5CQez/34IRWOesfsKFm3BvLYLIgLtoEwpnTRxdTCfh6OUocg0McR9ws6ZTTK
 REu2gbks+Ce3G05Ps52gHTaSflr9wrZ5PSYUfvdC5X9qGervj5HhAcBuFUbaDs0G2q/F
 D8QPgfjb1+5XIE89JVTLhbLRXSH0k4Hg02scxMhBQhLBkh0b4tz6fDx000+TNF5O+s3K
 V2mCQYgTGgOtv+6PXSCU13FdgVW+25i0RIlZ8F6qjH5qmu/cUCUcbFtnKJf+B7E7WhjL
 CtUsULXSsD/s+cKwMmWp1iO5SgfnbhPRUZF7lPR9cS983IjITr/WmC22+ZFBbjZ19vYK 8w== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by mx08-002d6701.pphosted.com (PPS) with ESMTPS id 3jdxmhrvt4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-sctp@vger.kernel.org>; Wed, 07 Sep 2022 10:32:44 +0000
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=Vt0fTMjNLKrPg0bT/y1E5eGSqFmhtxivT1hGhY1VUh43UJ2b3LFEL6HHp9YxHr6mkFdV7ANPeCEGOLiw4rEvjnHUc+zZyVpM3En8r7cv78os+6+5Q59WScAH+kUM3oXDdPuJaJIbWTb29GJTNAS9gcMAUQAA9atmNF98vZx+/Zyq+SR7GodILFXSw3G8dsUqyVXvcX7CuO/UFc1jseRtEtD2je9VpvfNpIb6g/jT5G+fJ0CNbjYjvk0pkhQq+GyvF91kCGR+ouIMJdltj77/NXVtIOiw/PpUwrP0MRV2qvT/EhhG4sa++bY7FfacUx7T9PAoQw/ggINe4dEopF8qTQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEq3l17KhqKniq5LEY6ayXp4VIB7srEugEjR5EGFiqs=;
 b=BwWKviYrzC6ky4Dj54cMI5r6cVNWf0sQw3Wk03NRbq/4n1M+Li+1mVKoi0wg6YvshKG+MkWdq1yDRhQflvhCxVn4Zrhn/zke9wkA1+F7BmIg6Tk6YuyVl0dESxEX8eQoxq1ZCSQ3YCJ6bzj3ti+Pf9l13RasKiWrElrd5/A+XZYMAflShDbjIrMXwf2R2u2RktgKkWlbc5B4CjlQmYNi5Kz1KDoyBFUet9Z3mjqLRk8SZ1vhkEVl/CxWepAreWkTSi+P4drflCkVdbyVrD5f4phtibdcTAz79wWovXznP7nBSCqbZk/sGDGF/D9hOk42RampBDOJ70uGAVOemueN5w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=fail (sender ip is
 144.49.247.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=flex.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject header.from=flex.com;
 dkim=none (message not signed); arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=flex.com] dkim=[1,1,header.d=flex.com]
 dmarc=[1,1,header.from=flex.com])
Received: from DS7PR05CA0077.namprd05.prod.outlook.com (2603:10b6:8:57::17) by
 BN8PR08MB5953.namprd08.prod.outlook.com (2603:10b6:408:ad::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.15; Wed, 7 Sep 2022 10:32:41 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::49) by DS7PR05CA0077.outlook.office365.com
 (2603:10b6:8:57::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.5 via Frontend
 Transport; Wed, 7 Sep 2022 10:32:41 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 144.49.247.100)
 smtp.mailfrom=flex.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=flex.com;
Received-SPF: Fail (protection.outlook.com: domain of flex.com does not
 designate 144.49.247.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=144.49.247.100;
 helo=mail.ds.dlp.protect.symantec.com;
Received: from mail.ds.dlp.protect.symantec.com (144.49.247.100) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 10:32:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAqNzdOepl4KWsUxcFDv2SCGLMnfUQsnnnm8kWGItjViKHnlO7BHLPns1QEqboayWybxFF4DoDnMhDUF3gJT6B8IP6YyIyCx4t9YzkLiWRxiKO/zr7WrpMv9TnAMRUIwg4HcnbpWvZNg8GmzuQz9IVt3uUQCG3oHSi2au1asLSg+WGVjk1y7Qb7lNbedFR3Jj1DolQCn++PZHWBxkgWDoE8dB9YYTTI8R7R+JgqDmRMjs0VRTz204ZMChdoIO6ZXENVGJEEgF+P4MNBcv+ZpsR8cFeez+6LolPFSFrdmB2YGO8k9w2TkdDTMniUnRyQlo+HJJOZxnxTTFa3enVMAqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEq3l17KhqKniq5LEY6ayXp4VIB7srEugEjR5EGFiqs=;
 b=Lp+eR0xdAJ1EoEeBXiT0frxAr3wErekhEKHLQrnAPAMHQ9RrhUcM1Y4JSsRjwC3OIZtuvTyGanwwIvL0sM5QWWuuHxaGaF3xwWuelaRZ/n86NyKdQtBYKXCG76g1uWtKdOAR3X88wix41LUSljtWsh49340qzv1V+LWxBq3FjsCsHLlAuC3g4LcCPdHUIe8fXikRAt4rZb2+/pDXwE8KFwJMDVAkPT1/UsnySDPzKHPrjAvvGBYiEB+822/zFPnbJ0d3v7EIlf+98Fc1L/bB9Wh75xZKRRMwG7bs9BAcGRFQ7TGW1KC9lOjnOHLNuHE6k5F2vrbVLYFEsg7lxonabQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=flex.com; dmarc=pass action=none header.from=flex.com;
 dkim=pass header.d=flex.com; arc=none
Received: from PH0PR08MB7241.namprd08.prod.outlook.com (2603:10b6:510:94::21)
 by BN7PR08MB4068.namprd08.prod.outlook.com (2603:10b6:406:8a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 7 Sep
 2022 10:32:38 +0000
Received: from PH0PR08MB7241.namprd08.prod.outlook.com
 ([fe80::f479:b53:f921:e9d3]) by PH0PR08MB7241.namprd08.prod.outlook.com
 ([fe80::f479:b53:f921:e9d3%9]) with mapi id 15.20.5588.018; Wed, 7 Sep 2022
 10:32:38 +0000
From:   Istvan Gyurjan <istvan.gyurjan@flex.com>
To:     "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Subject: lksctp-tools licensing
Thread-Topic: lksctp-tools licensing
Thread-Index: AdjCpSMGa++KjDF6QQGnGmtNwNLPbQ==
Date:   Wed, 7 Sep 2022 10:32:38 +0000
Message-ID: <PH0PR08MB724105AD73E9AFB3F12A0679E7419@PH0PR08MB7241.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=flex.com;
X-MS-Office365-Filtering-Correlation-Id: 027d9773-b9b3-4f1b-5b7e-08da90bc4b30
x-ms-traffictypediagnostic: BN7PR08MB4068:EE_|DM6NAM11FT022:EE_|BN8PR08MB5953:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: +tk+JCaIGhuWGO2TfPXN2dEZnzuhmCjV2aNp30hR1iS/+xzTy88mbEyAzONT9VsaqUUdXG7sey2QKv316kXOWNj/WwUqQvbx246ZGDq/d071bVtLB6tvgT/tV3bM+pDFQFzMScmc7/SA9QrJl1xno+PZfDkyiVj61Xc4H8ZxXT2wDl4qe4/kaSO6BMFBvID9bbZItYGD/HRRYTcQwV+FIH6oKpgiqw3ZuZR7m0yghPWTdmX0NBgU3eScfr3f7vt91z5mGFXd4TIaF5sZqxtnFlpynCBaRDYbTwLj/kIMHQgtCifPR8IWVUOxdere4RYOJ2L0/Ncr4Q48/g/LytwLgu/UgPQ8wVU9ZJadf3arM47nslt6WVjizX2UR8Pgc0jZz8NElgsiN1Z7y74XQdn7bnR7tLGsQQy2W+M35FNcA48yDe88M69n0Yi4QKJkycPJW8OpX90s/2XZNgkxP9jQHn2aqqjG5LAy0hm044b5mn4HET6XhbTKhLnOwyMH5SEY6HqS7HsiHqlMakSWbmE1XP4c4h03uotUeOR4auath/fY+i3hGgHXFbeCWrmYOdQRlOBx6GtXk+BZlj1HNb43IzdRNDeepyMTHzUZRuLorGcmuGYcjT75tfLVNUijQNYrMvNyGA1a+ANNSQv0R16Gfa7ka7k84D2xq/n7jh630ekh6OvgPmTay/jvgnw2wFomUg7q7m5PRsD3RrHhfKYkIRiadw1WnVthqjrrmlw0G2ERbNWpis4VJB9OCSarwyIP98soBMa4TP2ei6Kg6Q7EgQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR08MB7241.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(3480700007)(4744005)(316002)(52536014)(38070700005)(5660300002)(55016003)(6916009)(2906002)(66556008)(64756008)(66446008)(8676002)(8936002)(66946007)(66476007)(44832011)(33656002)(76116006)(83380400001)(86362001)(478600001)(41300700001)(26005)(71200400001)(38100700002)(186003)(122000001)(7696005)(6506007)(9686003);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4068
X-CFilter-Loop: Reflected
X-DetectorID-Processed: db4f4c5a-5dd2-4f21-956c-7ab15d947193
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: de9e5ef6-23c1-40ea-cbcb-08da90bc494b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BFIGP1aKCFn9kTsIsrQpSQrrHJU2FdGWyrXFLyB/Mrn4aXabivnMNWi6ZDmti7fpjzMiHArfksSmFlyvli/i/dUn/41vdYBkHg89rghqh4IH8+hYw62Zy8IqhcHq1omhFKpUJASELLE84zumnaX4hRM2XeRUMRmP0ZcAXBPYKcWSltVjIddxA7NyKGHyOcBvyCyXV4FBRC0tjWi3LyvVSa6WWfPcgCf7Ebq4D1jRC89GYgDQYj+qDXe7GvFycK5kPWhZRUQCOyPw37vEhlpH2LU2aHPkJ+Dbg0LyksWYCmRRbBu0AprcTRh2SvLmCJJHZ1PBQ7F/p9XoCCQivn8TxuPqfGgOyoAw9mkVgzIZDoN5Wadh5CUUQMu4lU6bWpyRTKfjAKz/F+2shM80VU8hDpSZnlxwRfiMLGcIW8cPG2gH3e9xje8kDbyscN6dbrs5yKk0anS6Js6ICSXHNLF9JX9tNSfpag4uYOB6BI4oT4joyFmNyFuL5ou9f9VFVFkKSxTjwhPqh9Shr17abg9w3BEDQnLloHaa1v98AsIj64Wa1ujyVmqWgSVPCuuRx+FQ8Vw1cG0qDHeMQVMc8tNoZrOT836wj25lNkEoPvja9Ekpw1p2xPUb8C3lsFFWtSIHGEroAPMyy8Jkt9RAqjTQeW8EAU5FW8RbILw7qXJXGmTCGGIpqJUuUCLpJvalBNrO6BV8+rU8S/VdmRlo/wVm49jCGbhs/cgVXRsmKhdtnUeDSgZW+u91ZI9Y62xlqY4Sd0q9oFROQrvt3fIW+Ovv6VnZ1CyzJC0LL6rtG6OAiMJxs4UYritZs9ku+3YSxa2y
X-Forefront-Antispam-Report: CIP:144.49.247.100;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.ds.dlp.protect.symantec.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(136003)(376002)(40470700004)(46966006)(36840700001)(33656002)(70206006)(8676002)(6916009)(316002)(82310400005)(86362001)(47076005)(26005)(9686003)(83380400001)(186003)(336012)(70586007)(8936002)(52536014)(4744005)(40480700001)(356005)(2906002)(81166007)(44832011)(40460700003)(55016003)(5660300002)(478600001)(41300700001)(6506007)(36860700001)(7696005)(82740400003)(3480700007)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: flex.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 10:32:41.4027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 027d9773-b9b3-4f1b-5b7e-08da90bc4b30
X-MS-Exchange-CrossTenant-Id: 3f0e69e0-eb38-4eb2-b4ee-52919719d31e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3f0e69e0-eb38-4eb2-b4ee-52919719d31e;Ip=[144.49.247.100];Helo=[mail.ds.dlp.protect.symantec.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR08MB5953
X-Proofpoint-GUID: fZfmUBAjs5dm6DDabKLq4BOyn4UgyLgZ
X-Proofpoint-ORIG-GUID: fZfmUBAjs5dm6DDabKLq4BOyn4UgyLgZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-07_06,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=380 malwarescore=0 clxscore=1015 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209070040
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Dear lksctp-tools Maintainer team,

We are planning to develop an application where lksctp-tools would be used =
together with other OSS components that uses Apache License 2.0 and The Ope=
nSSL License. Those are in conflict with the GPL-2.0-only
license of lksctp-tools.
Do you have any plan to update the license to GPL-2.0-or-later?

Best Regards, Istvan Gyurjan

Legal Disclaimer :
The information contained in this message may be privileged and confidentia=
l.=20
It is intended to be read only by the individual or entity to whom it is ad=
dressed=20
or by their designee. If the reader of this message is not the intended rec=
ipient,=20
you are on notice that any distribution of this message, in any form,=20
is strictly prohibited. If you have received this message in error,=20
please immediately notify the sender and delete or destroy any copy of this=
 message!
