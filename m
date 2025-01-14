Return-Path: <linux-sctp+bounces-318-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B669DA112A4
	for <lists+linux-sctp@lfdr.de>; Tue, 14 Jan 2025 22:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0A507A3E7D
	for <lists+linux-sctp@lfdr.de>; Tue, 14 Jan 2025 21:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B3120CCD8;
	Tue, 14 Jan 2025 21:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fWP/9Q6E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SQeFPiHA"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1081F1CDFCC;
	Tue, 14 Jan 2025 21:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736888444; cv=fail; b=GrKbu26V0RsLRqaKWTiuloymkV3pHedgJeel3MOlzBmW9gOPLZr6T4aEvceo2YEdHmW6sINrqgND9lD14Y4Lo+iY5VZclGaInQo3ZTPWhj5s7qHktMlMrR8zSUIjIIqeR7NTpmT0WlEllLEiW6ObIPC/ffDQr+LCRKdIkD676f8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736888444; c=relaxed/simple;
	bh=ltCGTfA92YglPGP/+oQFBS9jThH12LRviQpkAbJpBb0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZT4T8B+V3xM1dZlCPruK8J2YyssIR/V3Xo9qdXbmocXOqn/225WWA6KAYu3mLh7ZpGMff2l5Lc/HkJhTaqi0gBRl6402hZ6tlUj1QMLCEjVdVBxlyZGSSswBxK3RA07QGw0r3rogb3JsqZRCQeVS6wqk+bstXplpvk1A95Ktt04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fWP/9Q6E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SQeFPiHA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EIXs0F019432;
	Tue, 14 Jan 2025 20:59:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ltCGTfA92YglPGP/+oQFBS9jThH12LRviQpkAbJpBb0=; b=
	fWP/9Q6ER7JOi0yvBYTF8XhcQCwup56GSwPeQqSWmepPbKiBGu8jUlXURgKzXBW+
	wLpBy02gGBGCTcQOYicqDsxmWyhLYs429tf3pJrMk9lJkzGPD/+V+JL/SjtI72jR
	HDb5+lkeSTBUnaD9L9NfOWuiN4tmd6YgXz3pqIdtlkrGRxj1HRyqZl16LOurbGTr
	suAbRW13E+mgvxp1UeNIfBLyn8uzC3qgY4LI1hm//URrQglxJ+gpAI2qABniHF4f
	UEt1se5muHa8RJnqSQd2xQ5/EZytmfZJvLO5Vk/idl2ekaebpBjL+/eAGXaoZEGR
	kIITWL1rTDaoFNVCerw2/A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443f2bxn5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jan 2025 20:59:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50EKN4nS038991;
	Tue, 14 Jan 2025 20:59:33 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 443f38mnpd-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jan 2025 20:59:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efCWEhHmt8J4fnTcBqWEcarMf1EeQughurqQePEAWCopa8S9d+5pQ+Bd54H9vmmShRvQqpi0pDdyM2ZP32x7eWnU2kujNcuLPnMMOau4+k4Bp2vpNt5QCZhPiZPBi/Wx0EXjAd1Uu+mBTxDvW1NJe0zzQLTb4KopW2D2fbtKHGBymqXaz/PBMPQkDF73yahG5QMhypsiYQaplJCTAA9JI0/idS7J/fTlb8Dz1eeP26aHD1GT01ld+mNagcFBYsMrLtUEJmf6ZcfokHx0shWgK00ydFEwXztamgLkSgHx3nxMhepiAW9S3psn2Nuzsv/PNFBGyTWlmJAqwiQCccxqnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltCGTfA92YglPGP/+oQFBS9jThH12LRviQpkAbJpBb0=;
 b=Opl0/Ts7Lj8nFKYUuRA8HuoeyX07FRXIWf2hRVyre34p/P/pmjjM/gnyGlqLCG6LiudVNSwgt/tkUD9A5oSXKYDDYFAB09n++LsKyq2x1VMj4byn/oQYmBYQFey21G6bE/wAqRmLuEQ+MPBu4vUEfpfvnxpBDcLJPX12syG583EwCtWMG47vSVQmC6DD6T0Zhrbt+i7mUGmRWqMgnwcgdZA5Le59ASe4fG4pOEvnKAc8F9dMIz+ARzFQYTkVpXjGo0kg+jIcTjsOsqBlheOVDXfj5d8PIpuUkV32vQgr0n4T3UAINmMHURfI2giCOxOgfmOziBSeGRBxwQ/7V/avRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltCGTfA92YglPGP/+oQFBS9jThH12LRviQpkAbJpBb0=;
 b=SQeFPiHAtmKH9t7fO4q63976TKeIiK46Lin9ZJcLDw4N2+xjHjM589p/vBfhf1wXTAQ2a8cAaUb8GIlSIuMzYmfR5CQywJ8Rsvda2mU5XN5ZNZDyr3OXYcbenim6TFRQ4kB/GcSS3AHODOPtzPNNGSiaE2R0O+f6WX2QI0kQlpY=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by SA1PR10MB6416.namprd10.prod.outlook.com (2603:10b6:806:25b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Tue, 14 Jan
 2025 20:59:26 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%7]) with mapi id 15.20.8335.011; Tue, 14 Jan 2025
 20:59:25 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "kees@kernel.org" <kees@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>
CC: "kirjanov@gmail.com" <kirjanov@gmail.com>,
        "socketcan@hartkopp.net"
	<socketcan@hartkopp.net>,
        "linux-cifs@vger.kernel.org"
	<linux-cifs@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Michael Christie <michael.christie@oracle.com>,
        "jreuter@yaina.de"
	<jreuter@yaina.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        Dai Ngo <dai.ngo@oracle.com>,
        "ying.xue@windriver.com" <ying.xue@windriver.com>,
        "kbusch@kernel.org"
	<kbusch@kernel.org>,
        "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>,
        "kaishen@linux.alibaba.com"
	<kaishen@linux.alibaba.com>,
        "thuth@redhat.com" <thuth@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "nabijaczleweli@nabijaczleweli.xyz" <nabijaczleweli@nabijaczleweli.xyz>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "okorniev@redhat.com"
	<okorniev@redhat.com>,
        "jmaloy@redhat.com" <jmaloy@redhat.com>,
        "guwen@linux.alibaba.com" <guwen@linux.alibaba.com>,
        "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
        "tom@talpey.com"
	<tom@talpey.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "ignat@cloudflare.com" <ignat@cloudflare.com>,
        "tonylu@linux.alibaba.com"
	<tonylu@linux.alibaba.com>,
        "wintera@linux.ibm.com" <wintera@linux.ibm.com>,
        "isdn@linux-pingi.de" <isdn@linux-pingi.de>,
        "mark@fasheh.com"
	<mark@fasheh.com>,
        "gfs2@lists.linux.dev" <gfs2@lists.linux.dev>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-hams@vger.kernel.org" <linux-hams@vger.kernel.org>,
        "alibuda@linux.alibaba.com" <alibuda@linux.alibaba.com>,
        "lucien.xin@gmail.com" <lucien.xin@gmail.com>,
        "arnd@arndb.de"
	<arnd@arndb.de>, "benve@cisco.com" <benve@cisco.com>,
        "marcel@holtmann.org"
	<marcel@holtmann.org>,
        "mlombard@redhat.com" <mlombard@redhat.com>,
        "yajun.deng@linux.dev" <yajun.deng@linux.dev>,
        "sagi@grimberg.me"
	<sagi@grimberg.me>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        "open-iscsi@googlegroups.com" <open-iscsi@googlegroups.com>,
        "konradybcio@kernel.org" <konradybcio@kernel.org>,
        "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
        "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
        "syzbot+d7ce59b06b3eb14fd218@syzkaller.appspotmail.com"
	<syzbot+d7ce59b06b3eb14fd218@syzkaller.appspotmail.com>,
        "takedakn@nttdata.co.jp" <takedakn@nttdata.co.jp>,
        "mostrows@earthlink.net"
	<mostrows@earthlink.net>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "gnault@redhat.com"
	<gnault@redhat.com>,
        "chengyou@linux.alibaba.com"
	<chengyou@linux.alibaba.com>,
        "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        "James.Bottomley@HansenPartnership.com"
	<James.Bottomley@HansenPartnership.com>,
        "kch@nvidia.com" <kch@nvidia.com>, "f6bvp@free.fr" <f6bvp@free.fr>,
        "marcelo.leitner@gmail.com"
	<marcelo.leitner@gmail.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "lduncan@suse.com" <lduncan@suse.com>,
        "yunchuan@nfschina.com" <yunchuan@nfschina.com>,
        "ms@dev.tdt.de"
	<ms@dev.tdt.de>,
        "gouhao@uniontech.com" <gouhao@uniontech.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "penguin-kernel@I-love.SAKURA.ne.jp" <penguin-kernel@I-love.SAKURA.ne.jp>,
        "jaka@linux.ibm.com" <jaka@linux.ibm.com>,
        "jiri@resnulli.us"
	<jiri@resnulli.us>,
        "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "ocfs2-devel@lists.linux.dev" <ocfs2-devel@lists.linux.dev>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>,
        "mhal@rbox.co" <mhal@rbox.co>,
        "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
        "doug@schmorgal.com"
	<doug@schmorgal.com>,
        "anna@kernel.org" <anna@kernel.org>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "twinkler@linux.ibm.com"
	<twinkler@linux.ibm.com>,
        "johan.hedberg@gmail.com"
	<johan.hedberg@gmail.com>,
        "vincent.ldev@duvert.net"
	<vincent.ldev@duvert.net>,
        "cleech@redhat.com" <cleech@redhat.com>,
        "error27@gmail.com" <error27@gmail.com>,
        "dhowells@redhat.com"
	<dhowells@redhat.com>,
        "courmisch@gmail.com" <courmisch@gmail.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "yinghsu@chromium.org" <yinghsu@chromium.org>,
        "waterman@eecs.berkeley.edu"
	<waterman@eecs.berkeley.edu>,
        "horms@kernel.org" <horms@kernel.org>,
        "linux-x25@vger.kernel.org" <linux-x25@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
        "tparkin@katalix.com" <tparkin@katalix.com>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "robin@protonic.nl" <robin@protonic.nl>,
        "jchapman@katalix.com"
	<jchapman@katalix.com>,
        "hch@lst.de" <hch@lst.de>, "jlayton@kernel.org"
	<jlayton@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "wenjia@linux.ibm.com"
	<wenjia@linux.ibm.com>,
        "quic_abchauha@quicinc.com"
	<quic_abchauha@quicinc.com>,
        "aahringo@redhat.com" <aahringo@redhat.com>,
        "atteh.mailbox@gmail.com" <atteh.mailbox@gmail.com>,
        "linkinjeon@kernel.org"
	<linkinjeon@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "sfrench@samba.org" <sfrench@samba.org>,
        "sgarzare@redhat.com"
	<sgarzare@redhat.com>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "neescoba@cisco.com" <neescoba@cisco.com>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>,
        "constant.lee@samsung.com"
	<constant.lee@samsung.com>,
        "senozhatsky@chromium.org"
	<senozhatsky@chromium.org>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>,
        "kernelxing@tencent.com"
	<kernelxing@tencent.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>,
        "almasrymina@google.com"
	<almasrymina@google.com>,
        "kuniyu@amazon.com" <kuniyu@amazon.com>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "mgurtovoy@nvidia.com"
	<mgurtovoy@nvidia.com>,
        "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>,
        "teigland@redhat.com" <teigland@redhat.com>,
        "andrew.shadura@collabora.co.uk" <andrew.shadura@collabora.co.uk>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "neilb@suse.de"
	<neilb@suse.de>, "v4bel@theori.io" <v4bel@theori.io>,
        "palmer@dabbelt.com"
	<palmer@dabbelt.com>,
        Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: [PATCH] net: Convert proto_ops::getname to sockaddr_storage
Thread-Topic: [PATCH] net: Convert proto_ops::getname to sockaddr_storage
Thread-Index: AQHbUCw7YUNitVM1nEGsoCrgU3yw37MW7gkA
Date: Tue, 14 Jan 2025 20:59:25 +0000
Message-ID: <00a27f75247a1f88fc213f0a363532683c33c6ac.camel@oracle.com>
References: <20241217023417.work.145-kees@kernel.org>
In-Reply-To: <20241217023417.work.145-kees@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
autocrypt: addr=allison.henderson@oracle.com; prefer-encrypt=mutual;
 keydata=mQGNBGMrSUYBDADDX1fFY5pimVrKxscCUjLNV6CzjMQ/LS7sN2gzkSBgYKblSsCpzcbO/
 qa0m77Dkf7CRSYJcJHm+euPWh7a9M/XLHe8JDksGkfOfvGAc5kkQJP+JHUlblt4hYSnNmiBgBOO3l
 O6vwjWfv99bw8t9BkK1H7WwedHr0zI0B1kFoKZCqZ/xs+ZLPFTss9xSCUGPJ6Io6Yrv1b7xxwZAw0
 bw9AA1JMt6NS2mudWRAE4ycGHEsQ3orKie+CGUWNv5b9cJVYAsuo5rlgoOU1eHYzU+h1k7GsX3Xv8
 HgLNKfDj7FCIwymKeir6vBQ9/Mkm2PNmaLX/JKe5vwqoMRCh+rbbIqAs8QHzQPsuAvBVvVUaUn2XD
 /d42XjNEDRFPCqgVE9VTh2p1Ge9ovQFc/zpytAoif9Y3QGtErhdjzwGhmZqbAXu1EHc9hzrHhUF8D
 I5Y4v3i5pKjV0hvpUe0OzIvHcLzLOROjCHMA89z95q1hcxJ7LnBd8wbhwN39r114P4PQiixAUAEQE
 AAbQwQWxsaXNvbiBIZW5kZXJzb24gPGFsbGlzb24uaGVuZGVyc29uQG9yYWNsZS5jb20+iQHOBBMB
 CgA4AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEElfnzzkkP0cwschd6yD6kYDBH6bMFAmcX6
 VYACgkQyD6kYDBH6bOyCgv/VwoK9G/a1YjxnagrX/D9idqZvE1WDMStJWeTuec5nUH34qsZ1m3z+D
 larIyWU4XF4AfwXs1vwqZZnr7o1kcKZyAE1zx9RyOcDnepqXSa+HxqBfPF+xZ6wLXspF0pDw0QjZF
 hBoctey5cV5zNR8zaHt4bWvEsKyVZfcpVS8rRx1UZoivX4RHQzgfkpNwi6T4YDLKhXUNVktXrIL5h
 92uvUQZioCiioCBXnDSAwdUhT/yLFS3AptegnpDxwq02mE9E99PvEpa5My+Dy6dNlarREnc5H3kO+
 YCK/QXFZ0176Hzb+9xA7F3HAUoV+dBZflJqGeVVxzVCKd6AlZbi97QyXkMnaWJLLn+bHNPF4R3i44
 Lcfae2Vp5u/i9397s/rNOCR+ipi2bMboWixEuODMMP0pEdozBulgLje3j3FGP6HcTqF2QRyJo5tZL
 163mB3MxVUtIi0EbUbBsghsQN1vXj6JOgGuzdqRK5eW6o+IXLnKjQNo3TPQga8BIIbB0WkSs/
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|SA1PR10MB6416:EE_
x-ms-office365-filtering-correlation-id: ac95a9a6-0497-4a7c-2d9d-08dd34de5446
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018|41080700001;
x-microsoft-antispam-message-info:
 =?utf-8?B?VjJ3ejJsdVVDWXRIMi9GQVdSd1NwY0JsZVBnclAwZnFOYUFIVUJmbXIyR25F?=
 =?utf-8?B?MEd2cllIdUhhUXdBNW1leGpNOTF6MWI3enpOb2w1SkMvQ01YQjltYUtjdGtK?=
 =?utf-8?B?NnJBUWVHRHJqUDBtL2x6cUxIQVlDSUF2a2pmM0YwQWYxWkowNTBmNkhwL29j?=
 =?utf-8?B?LzQ2KzBuZ0FjaUxFZmR0UWwxVm1WVFZVOFB2SFU3OW1nRC95Q0FmZVBuWXZO?=
 =?utf-8?B?akppSzAwejd0b2o3MGtnRnJhTnIzTzJvMHd6aVNEUjh5YjBWWVpQaXpDcjQv?=
 =?utf-8?B?UkNzMnVCdG5yam5oNlRDWTJBWmx3OFVpL1VESzFEeHpwbGM1QkRnOVd3Q3ZF?=
 =?utf-8?B?djR5TGRINE9pWG43OHk3VllveVhVNGhxS3paWTUvMGpGQm9Qdm9xVUFzQ2hE?=
 =?utf-8?B?dFVzeW1XSFBiVnRxVVk4QTNNZjJ5WW5KeEJnMWl1a0FQZjNlWmhmdkJFamNB?=
 =?utf-8?B?M09tNmF4TkJkTEVJclZYaFlPR1JDL1R3SndvMllHME0yU2JJTHFuUVJmQmE2?=
 =?utf-8?B?MnVMKzdaM05ndGVFWk90dkxKeTVUUVdIMXV4UmkyL1R6SXRKRlk4eWFzYldV?=
 =?utf-8?B?WHYvOFl5eFNFdnNQQVh6akdSc2JQU0E4WWpZeUl0Vmgzbi9HV09vaTBubUVY?=
 =?utf-8?B?cmtnd2NuNW54dXBIL2RhTW5GRzBxaElRRkdiUTJSWG9NN0hZV1hxazBYQUJX?=
 =?utf-8?B?ZGU4SXloVzhNdnBmVktXZEJMRDVrQWRBQ1RFaHFuNCsxZGdON1k5SzA2NzRk?=
 =?utf-8?B?K3kyckxZTWJQR2plQVYxVXlYb1pxR1llUXJ4K05VL3BnUVhhRjhrTHlzQjFz?=
 =?utf-8?B?blpXckJzV2g0S1g5UVZaVlM2dVNKUVJXYVZFOS9CSGlXNG5QTGgzWUd0dGhV?=
 =?utf-8?B?Y2o0eUVLbmI2MFJSSDVRSk9RRzdiWnNQQTUwajlscTRRek5BY0lnQlZXZk5G?=
 =?utf-8?B?RThQYUc2djBNeGxNbnFGQmdBTVFRQWtLT3FHYUZHYklRdGxtVU9jMURaMkxH?=
 =?utf-8?B?cXVMWUxueEc4WFl3ZzdQOWNmYVRVWXF2QTJQQmlReWU2b0hnVGk2VHpsZHBp?=
 =?utf-8?B?UE9WYkhUWWlJQ0ZkaHgweCtxeVNiM0o5Yi94Qnk1R2c5bUVWZG9EekdRNGFs?=
 =?utf-8?B?enp0TDBjZi9UWndSNmhOajFvQ01Tc1pqelVuQWpIUnpMVzZ3djk0b2VvSDRY?=
 =?utf-8?B?VHRwZS81eE1xSWMwNkF5cEQvTjhYb0FteDVJUVMvUDZmMytIMVB1d0RGN01L?=
 =?utf-8?B?bWN5ODh3ZFhGcjRIaWorZnJxb2JOZGRxR0ZwTXd6dXk2THArNDJJUmdzVXp0?=
 =?utf-8?B?OEZza1U2LzBDaWFaV2U2WXFlNk90N0NlUDVTZ2x2Zis0NnBQdkN0WHE1UnlH?=
 =?utf-8?B?VE1qaEE1d1UrdU1QbkdxS3BDbVlZRStKOVNSbkkwZHZBMzdZSStBblJ1dStN?=
 =?utf-8?B?RjMvOVpYSzcrL3pSdXlUN014Q1NFRnZxekJUUVpFcVpQY2pRYWJMakEvRCtG?=
 =?utf-8?B?T3QrOUF3VmlJRll3SUdmakc3UUc5Wk5EUDBIeTAwUEhSSHlhZHN5WTd2U25E?=
 =?utf-8?B?UTV6UVd2MkorYTd4ZW1MVWQvZ0JFL040YVFsZnBmT0RZbytjSDgyU2I0Rkxw?=
 =?utf-8?B?cTJVTzNWdTl5ZE1RTDhxMTczdys3OXY5L21MakV6aUg0N0M1bGd4UElibDRE?=
 =?utf-8?B?ZXh0ckI1NWoyMkxsQVp1OE11Y2d0a0UwTXN2NWpXYWR3eGV1c25hM21jZHdm?=
 =?utf-8?B?dW1mMytOb2x2S0FSa3kvZG1FeThXSU1jbWtvWGhuU0krTjl4ODlvd0VNOXJZ?=
 =?utf-8?B?dk14cVVIQ0dqWmprQ3pDa3RBMDZ5MTNQZDVIRXBQWmplQlJTNUM1RGlMTnht?=
 =?utf-8?B?Y3NFVC9mcElUT2pNWE9ycnVHMDRHNDgvRjF6Q1lZRWcyTytWbisvelMrUEdh?=
 =?utf-8?B?UytGWjc5WGY0dzZlWHlvOU5sWWRRY3E4NE14L0VJbytlZEVaRmJUbnZLNU9L?=
 =?utf-8?B?aWxYNGxCMUZBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018)(41080700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NVFScTRCMWpoZzNHQjRUTmt3dkl3WWxleGxSdVk0ZXZUaUh3R2RCNnBsSFda?=
 =?utf-8?B?aVl4WkpXMnNLQmlmTjhNdzllSys4aTYvSmJUODN1Y3oyTTJJSHpucy9ZY29T?=
 =?utf-8?B?cE54SGw2SnZaK0ttTml6OWVDeDZPRUlwd1ZWRGRKTGtvNmJQbmIwNU9uSVhN?=
 =?utf-8?B?MEZ5MDh6ZE84dGJjOTNsc1BYcWVYbUhOeWIxS0kvZ1N2MHIwQklHUlpyaHZ0?=
 =?utf-8?B?MExIVSs2cVJsT3hsV2FRRFA0eEZKL0M5VzNudmo0QUV0RCt6QnlLb0lIWWFG?=
 =?utf-8?B?MWtBVlo0VVdRbUN0T0d5S3Q1U2tFL0J5TUprckM1WHNUV0xybFF5M0l0N2FU?=
 =?utf-8?B?SzVHZjRGNkN2RmlyTDAzUmVCZHBKNUM4VWlHK1lGbGh6VmprVFV0T2Z1TnVB?=
 =?utf-8?B?dXpuQklYT0R0dW5kWmhwU3o4MEhGZnVSTVEreGllV3E4MHMxT09tSkE3dUEr?=
 =?utf-8?B?Nnl3TEJVQ3o2bUUydDJzeEtYSTJDdTVGUklnSnFYQnNUcHdXWFRrMkJ1SFFi?=
 =?utf-8?B?KzZ5K2k0NVhQSXJ6cGdjZ0hadkdqTzNWQTFCSC9PWGtXamVveFZzVHhZenIz?=
 =?utf-8?B?L2d2OVZZS0RURnFLNVpqY1lmUnhqR2Vob0RxN3dXN0kxb2QzSlV6eEowKzl2?=
 =?utf-8?B?SmVmSmNha3NTVDZWVXkvN3ozOE1md3hPaVpQUmhpSkp0N3pPTFRLVEdkOHZ2?=
 =?utf-8?B?ZzJVQldQQVJLUWt0cTBUNTkxcHNFSmJMZU5PL1RYOGlBQlNaTmY3OUZXUWtK?=
 =?utf-8?B?NmhSa3IySTR3Mk5lOURzcStscFM3ZjBWd0JsWVlyeVdSSkpoVGNzTjJVQWd0?=
 =?utf-8?B?bFFTeEoxbmJ4VzlSZUlBSFNVc2hzZFpqTjJTQmRmZHpwclk0UDRqd1BtdGRt?=
 =?utf-8?B?bkdYZjdudWRMZHNXdkVpQXJnajE5SmQvUjJLTVphTkpUeGtWUnlPcldRWkU2?=
 =?utf-8?B?MTZ6RndtUk5rVUVScXlJdFBEeEdkczlpaGJwZ0EvL3ZCUElRWnVCRWJlYnhT?=
 =?utf-8?B?TGFQWlRGbjZTNHBIRklhVDJoTUVMZTByOTdsZ1dtNDlja3dZbC94RXAwQWFO?=
 =?utf-8?B?OHlCMDJwL0liTWxOV2NQK1RmTzhNeGsrTy9mUG1WdmM2bnJ2UnJoenljbUIx?=
 =?utf-8?B?MWMwSjVxTWZoRURaVzlVb1JMZ25RSVZHTndYOUI4QlFqRUFsYUpocTFrWXgr?=
 =?utf-8?B?dlBsTm1IZU9aNm1UZ3BSRWlQdlhTZTdNbDJmV0ZVS21wSHpKWCtIT3NzeWZF?=
 =?utf-8?B?dFV6Sjd2RXcra2hyMHhlV3Q5MG9FbHNDRVZZMlR5c0N1bm9tNXJ5RjJBWHZm?=
 =?utf-8?B?THFENG40RnVLRTBGR2h2M2VZb2FVSmltMWo2R253VEw2cDd4YlI2VUJLVGRs?=
 =?utf-8?B?bEF5N0tpMVVaS2FLb0NIR3BkOS9YN2N3MHhwS1pxSUl5WWVDdVhLTXM5WldB?=
 =?utf-8?B?WUFlY2p1blVtYXo0ZmlIVnRSUFlZR1hHcXdyZlo1SWF4emg3MWVWMm9FNU5F?=
 =?utf-8?B?ZEV6TU45eDhYVTJUN0wwK0xKNnVDY1FMZmkrUGJPWmpTZzc5RVdJdE9OODQ0?=
 =?utf-8?B?U3hHQmFZSjI5Y2RZeHNSU3QzVEg3dU85OXh0R09pVnJ0dXN3YjNYQU5YaU15?=
 =?utf-8?B?eGZtc1ljUHc5cVpmeXg3VkZYcXFYTWRRajV1QkhqS3YwVStvemVVNDlMR3Y5?=
 =?utf-8?B?T3FCVHJncDMrdU5tNTRHM05zSTI5MkhpY0JCN1Z0blRwd1Z1dnhQc3V3LzJq?=
 =?utf-8?B?QWNITUhjR3dNejQ2MEpVdlRhUWJuQTM1TDZUNGhLelZiTDZScEpNaC94WTJ6?=
 =?utf-8?B?bUJtbG9jK080ZUlVc0wwVnVDbllLQkFxRkZxY25Hdk5DVWxSM1Ewa0IrNlBi?=
 =?utf-8?B?QWpIL1hsaUM3TFpBdHl3VE5YdzJ2TmJZcHBLeW12YzB4WmUxNFhHVHVsYlFZ?=
 =?utf-8?B?TmJ2czYxdjFFdUlJcHJHeGtNMmQ5RE96ek1VOFlWbTFWb3g2SGQ0V010dmFU?=
 =?utf-8?B?QW5JNnBDNVprM0t4WUVhdlJNVHFPb1Zyd0tNaUVFak5lbWFwN3lYUkZzMlJC?=
 =?utf-8?B?T2E5TlQvN0F3RTRTRHZOdEJoN1BrRy9vZEpzMkMwK0p6S2JCeGQ0aGNTLzcy?=
 =?utf-8?B?VUYyWkszcUJrbUtEMFg1VzA3YkFmVi9rRHcwME9Fd1FZR2pJRVZaekpjSGg4?=
 =?utf-8?B?dmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DAF6B5CE30CE74493D983CB1E317341@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MXYmW5OucoPHsb+w4RVgFPk+HwubPD74d1RxN2ONzy1+t5mOsEmKHjpp/C7zaC2Lv5Z5ETXjcHgX5P35vlz8ATf+dseuJhEZaFC04P4qqTwNxX8VHIaRo/n7iJsM8DlHIP44/1lPlwdQGr2oDVvU5upurTKvgMQtPqj27TvG0q2nhKeukVoGKVeA6QYo9nJuNQn8+Uequsz/K5SwePPRyO5KoT4VoH5xybrByYle520T6u/5FxIpgAQft5ORTdeuIAkgSRomcIa2TNIVO28XUEP/mx9T74L5M7cz5HAvaKzgFLXMeXYfrFWcDiywqCSKc6oenI0k5AMqzYOkraHCsdpHaH9tcZfMKCuCUzS9MfYHd+2n5YJbtXiNZB1Z2OAks/BTPLk5WG5Z3WU1ojOeAmUM0YgKsZQmqZNVZWWNC7kxSzwof/tYyGXQEVr2vLjiLkCdQTxmlc7n2QwMbJX0FoeebVXKgpn8gw5l9V133uDOQP2prJHVyQ1a2RCTnbesSRbbFPNAynX0/wImvbOluJfZGwP/H5MdK9MdPFFnpibmuFODH4X+eHKwhOTpMU8YMDWcKuquiJwvFyYVZUXBsC+XN3v2tV33n3QGZM4EoSA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac95a9a6-0497-4a7c-2d9d-08dd34de5446
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2025 20:59:25.7722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H5HGbD1kaPg8wu5PNhmYhcWaptJTw7P6vK9lfdOejJqh6FfoIPRynMPWN47BmjlGJH8gEqsXzHTuAA2qGx9IlInOCfVBxw6Gy1f0kLuw5cU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6416
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_07,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501140159
X-Proofpoint-ORIG-GUID: YyrOFkhe5NwSh4tizZDCgFnJTaUMGOrI
X-Proofpoint-GUID: YyrOFkhe5NwSh4tizZDCgFnJTaUMGOrI

T24gTW9uLCAyMDI0LTEyLTE2IGF0IDE4OjM0IC0wODAwLCBLZWVzIENvb2sgd3JvdGU6DQo+IFRo
ZSBwcm90b19vcHM6OmdldG5hbWUgY2FsbGJhY2sgd2FzIGxvbmcgYWdvIGJhY2tlZCBieSBzb2Nr
YWRkcl9zdG9yYWdlLA0KPiBidXQgdGhlIHJlcGxhY2VtZW50IG9mIGl0IGZvciBzb2NrYWRkciB3
YXMgbmV2ZXIgZG9uZS4gUGx1bWIgaXQgdGhyb3VnaA0KPiBhbGwgdGhlIGdldG5hbWUoKSBjYWxs
YmFja3MsIGFkanVzdCBwcm90b3R5cGVzLCBhbmQgZml4IGNhc3RzLg0KPiANCj4gVGhlcmUgYXJl
IGEgZmV3IGNhc2VzIHdoZXJlIHRoZSBiYWNraW5nIG9iamVjdCBpcyBfbm90XyBhIHNvY2thZGRy
X3N0b3JhZ2UNCj4gYW5kIGNvbnZlcnRpbmcgaXQgbG9va3MgcGFpbmZ1bC4gSW4gdGhvc2UgY2Fz
ZXMsIHRoZXkgdXNlIGEgY2FzdCB0bw0KPiBzdHJ1Y3Qgc29ja2FkZHJfc3RvcmFnZS4gVGhleSBh
cHBlYXIgd2VsbCBib3VuZHMtY2hlY2tlZCwgc28gdGhlIHJpc2sNCj4gaXMgbm8gd29yc2UgdGhh
dCB3ZSBoYXZlIGN1cnJlbnRseS4NCj4gDQo+IE90aGVyIGNhc3RzIHRvIHNvY2thZGRyIGFyZSBy
ZW1vdmVkLCB0aG91Z2ggdG8gYXZvaWQgc3BpbGxpbmcgdGhpcw0KPiBjaGFuZ2UgaW50byBCUEYg
KHdoaWNoIGJlY29tZXMgYSBtdWNoIGxhcmdlciBzZXQgb2YgY2hhbmdlcyksIGNhc3QgdGhlDQo+
IHNvY2thZGRyX3N0b3JhZ2UgaW5zdGFuY2VzIHRoZXJlIHRvIHNvY2thZGRyIGZvciB0aGUgdGlt
ZSBiZWluZy4NCj4gDQo+IEluIHRoZW9yeSB0aGlzIGNvdWxkIGJlIHNwbGl0IHVwIGludG8gcGVy
LWNhbGxlciBwYXRjaGVzIHRoYXQgYWRkIG1vcmUNCj4gY2FzdHMgdGhhdCBhbGwgbGF0ZXIgZ2V0
IHJlbW92ZWQsIGJ1dCBpdCBzZWVtZWQgbGlrZSB0aGVyZSBhcmUgZmV3DQo+IGVub3VnaCBjYWxs
ZXJzIHRoYXQgaXQgc2VlbXMgZmVhc2libGUgdG8gZG8gdGhpcyBpbiBhIHNpbmdsZSBwYXRjaC4g
TW9zdA0KPiBjb252ZXJzaW9ucyBhcmUgbWVjaGFuaWNhbCwgc28gcmV2aWV3IHNob3VsZCBiZSBm
YWlybHkgZWFzeS4gKEZhbW91cw0KPiBsYXN0IHdvcmRzLikNCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEtlZXMgQ29vayA8a2Vlc0BrZXJuZWwub3JnPg0KPiAtLS0NCj4gIGRyaXZlcnMvaW5maW5pYmFu
ZC9ody9lcmRtYS9lcmRtYV9jbS5oICAgICAgICB8ICA0ICstDQo+ICBkcml2ZXJzL2luZmluaWJh
bmQvaHcvdXNuaWMvdXNuaWNfdHJhbnNwb3J0LmMgfCAxNiArKystLS0NCj4gIGRyaXZlcnMvaW5m
aW5pYmFuZC9zdy9zaXcvc2l3X2NtLmggICAgICAgICAgICB8ICA0ICstDQo+ICBkcml2ZXJzL2lz
ZG4vbUlTRE4vc29ja2V0LmMgICAgICAgICAgICAgICAgICAgfCAgMiArLQ0KPiAgZHJpdmVycy9u
ZXQvcHBwL3BwcG9lLmMgICAgICAgICAgICAgICAgICAgICAgIHwgIDQgKy0NCj4gIGRyaXZlcnMv
bmV0L3BwcC9wcHRwLmMgICAgICAgICAgICAgICAgICAgICAgICB8ICA0ICstDQo+ICBkcml2ZXJz
L252bWUvaG9zdC90Y3AuYyAgICAgICAgICAgICAgICAgICAgICAgfCAgMiArLQ0KPiAgZHJpdmVy
cy9udm1lL3RhcmdldC90Y3AuYyAgICAgICAgICAgICAgICAgICAgIHwgIDYgKy0tDQo+ICBkcml2
ZXJzL3Njc2kvaXNjc2lfdGNwLmMgICAgICAgICAgICAgICAgICAgICAgfCAxOCArKystLS0tDQo+
ICBkcml2ZXJzL3NvYy9xY29tL3FtaV9pbnRlcmZhY2UuYyAgICAgICAgICAgICAgfCAgMiArLQ0K
PiAgZHJpdmVycy90YXJnZXQvaXNjc2kvaXNjc2lfdGFyZ2V0X2xvZ2luLmMgICAgIHwgNTEgKysr
KysrKysrLS0tLS0tLS0tLQ0KPiAgZnMvZGxtL2xvd2NvbW1zLmMgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgIDIgKy0NCj4gIGZzL25mcy9uZnM0Y2xpZW50LmMgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICA0ICstDQo+ICBmcy9vY2ZzMi9jbHVzdGVyL3RjcC5jICAgICAgICAgICAg
ICAgICAgICAgICAgfCAyNiArKysrKy0tLS0tDQo+ICBmcy9zbWIvc2VydmVyL2Nvbm5lY3Rpb24u
aCAgICAgICAgICAgICAgICAgICAgfCAgMiArLQ0KPiAgZnMvc21iL3NlcnZlci9tZ210L3RyZWVf
Y29ubmVjdC5jICAgICAgICAgICAgIHwgIDIgKy0NCj4gIGZzL3NtYi9zZXJ2ZXIvdHJhbnNwb3J0
X2lwYy5jICAgICAgICAgICAgICAgICB8ICA0ICstDQo+ICBmcy9zbWIvc2VydmVyL3RyYW5zcG9y
dF9pcGMuaCAgICAgICAgICAgICAgICAgfCAgNCArLQ0KPiAgZnMvc21iL3NlcnZlci90cmFuc3Bv
cnRfdGNwLmMgICAgICAgICAgICAgICAgIHwgIDYgKy0tDQo+ICBpbmNsdWRlL2xpbnV4L25ldC5o
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNiArLS0NCj4gIGluY2x1ZGUvbGludXgvc3Vu
cnBjL2NsbnQuaCAgICAgICAgICAgICAgICAgICB8ICA0ICstDQo+ICBpbmNsdWRlL25ldC9pbmV0
X2NvbW1vbi5oICAgICAgICAgICAgICAgICAgICAgfCAgMiArLQ0KPiAgaW5jbHVkZS9uZXQvaXB2
Ni5oICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0NCj4gIGluY2x1ZGUvbmV0L3Nv
Y2suaCAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzICstDQo+ICBuZXQvYXBwbGV0YWxr
L2RkcC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMiArLQ0KPiAgbmV0L2F0bS9wdmMu
YyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0NCj4gIG5ldC9hdG0vc3Zj
LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyICstDQo+ICBuZXQvYXgyNS9h
Zl9heDI1LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNCArLQ0KPiAgbmV0L2JsdWV0
b290aC9oY2lfc29jay5jICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0NCj4gIG5ldC9ibHVl
dG9vdGgvaXNvLmMgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA2ICstLQ0KPiAgbmV0L2Js
dWV0b290aC9sMmNhcF9zb2NrLmMgICAgICAgICAgICAgICAgICAgIHwgIDYgKy0tDQo+ICBuZXQv
Ymx1ZXRvb3RoL3JmY29tbS9zb2NrLmMgICAgICAgICAgICAgICAgICAgfCAgMyArLQ0KPiAgbmV0
L2JsdWV0b290aC9zY28uYyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDYgKy0tDQo+ICBu
ZXQvY2FuL2lzb3RwLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMyArLQ0KPiAg
bmV0L2Nhbi9qMTkzOS9zb2NrZXQuYyAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0NCj4g
IG5ldC9jYW4vcmF3LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyICstDQo+
ICBuZXQvY29yZS9zb2NrLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNCArLQ0K
PiAgbmV0L2lwdjQvYWZfaW5ldC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0N
Cj4gIG5ldC9pcHY2L2FmX2luZXQ2LmMgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyICst
DQo+ICBuZXQvaXVjdi9hZl9pdWN2LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNiAr
LS0NCj4gIG5ldC9sMnRwL2wydHBfaXAuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAy
ICstDQo+ICBuZXQvbDJ0cC9sMnRwX2lwNi5jICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
MiArLQ0KPiAgbmV0L2wydHAvbDJ0cF9wcHAuYyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
IDIgKy0NCj4gIG5ldC9sbGMvYWZfbGxjLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAyICstDQo+ICBuZXQvbmV0bGluay9hZl9uZXRsaW5rLmMgICAgICAgICAgICAgICAgICAgICAg
fCAgNCArLQ0KPiAgbmV0L25ldHJvbS9hZl9uZXRyb20uYyAgICAgICAgICAgICAgICAgICAgICAg
IHwgIDQgKy0NCj4gIG5ldC9uZmMvbGxjcF9zb2NrLmMgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICA0ICstDQo+ICBuZXQvcGFja2V0L2FmX3BhY2tldC5jICAgICAgICAgICAgICAgICAgICAg
ICAgfCAxNSArKystLS0NCj4gIG5ldC9waG9uZXQvc29ja2V0LmMgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8IDEwICsrLS0NCj4gIG5ldC9xcnRyL2FmX3FydHIuYyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICAyICstDQo+ICBuZXQvcXJ0ci9ucy5jICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgMiArLQ0KPiAgbmV0L3Jkcy9hZl9yZHMuYyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgIDIgKy0NCj4gIG5ldC9yb3NlL2FmX3Jvc2UuYyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICA0ICstDQo+ICBuZXQvc2N0cC9pcHY2LmMgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgMiArLQ0KPiAgbmV0L3NtYy9hZl9zbWMuYyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgIDIgKy0NCj4gIG5ldC9zbWMvc21jLmggICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAyICstDQo+ICBuZXQvc21jL3NtY19jbGMuYyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgMiArLQ0KPiAgbmV0L3NvY2tldC5jICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgMTAgKystLQ0KPiAgbmV0L3N1bnJwYy9jbG50LmMgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgIDkgKystLQ0KPiAgbmV0L3N1bnJwYy9zdmNzb2NrLmMg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDggKy0tDQo+ICBuZXQvc3VucnBjL3hwcnRzb2Nr
LmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNCArLQ0KPiAgbmV0L3RpcGMvc29ja2V0LmMg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0NCj4gIG5ldC91bml4L2FmX3VuaXgu
YyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA5ICsrLS0NCj4gIG5ldC92bXdfdnNvY2sv
YWZfdnNvY2suYyAgICAgICAgICAgICAgICAgICAgICB8ICAyICstDQo+ICBuZXQveDI1L2FmX3gy
NS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMiArLQ0KPiAgc2VjdXJpdHkvdG9t
b3lvL25ldHdvcmsuYyAgICAgICAgICAgICAgICAgICAgIHwgIDMgKy0NCj4gIDY2IGZpbGVzIGNo
YW5nZWQsIDE3MyBpbnNlcnRpb25zKCspLCAxNzMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L2VyZG1hL2VyZG1hX2NtLmggYi9kcml2ZXJzL2lu
ZmluaWJhbmQvaHcvZXJkbWEvZXJkbWFfY20uaA0KPiBpbmRleCBhMjZkODA3NzAxODguLjRlNDZi
YTQ5MWQ1YyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L2VyZG1hL2VyZG1h
X2NtLmgNCj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2h3L2VyZG1hL2VyZG1hX2NtLmgNCj4g
QEAgLTE0MSwxMiArMTQxLDEyIEBAIHN0cnVjdCBlcmRtYV9jbV93b3JrIHsNCj4gIA0KPiAgc3Rh
dGljIGlubGluZSBpbnQgZ2V0bmFtZV9wZWVyKHN0cnVjdCBzb2NrZXQgKnMsIHN0cnVjdCBzb2Nr
YWRkcl9zdG9yYWdlICphKQ0KPiAgew0KPiAtCXJldHVybiBzLT5vcHMtPmdldG5hbWUocywgKHN0
cnVjdCBzb2NrYWRkciAqKWEsIDEpOw0KPiArCXJldHVybiBzLT5vcHMtPmdldG5hbWUocywgYSwg
MSk7DQo+ICB9DQo+ICANCj4gIHN0YXRpYyBpbmxpbmUgaW50IGdldG5hbWVfbG9jYWwoc3RydWN0
IHNvY2tldCAqcywgc3RydWN0IHNvY2thZGRyX3N0b3JhZ2UgKmEpDQo+ICB7DQo+IC0JcmV0dXJu
IHMtPm9wcy0+Z2V0bmFtZShzLCAoc3RydWN0IHNvY2thZGRyICopYSwgMCk7DQo+ICsJcmV0dXJu
IHMtPm9wcy0+Z2V0bmFtZShzLCBhLCAwKTsNCj4gIH0NCj4gIA0KPiAgaW50IGVyZG1hX2Nvbm5l
Y3Qoc3RydWN0IGl3X2NtX2lkICppZCwgc3RydWN0IGl3X2NtX2Nvbm5fcGFyYW0gKnBhcmFtKTsN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9ody91c25pYy91c25pY190cmFuc3Bv
cnQuYyBiL2RyaXZlcnMvaW5maW5pYmFuZC9ody91c25pYy91c25pY190cmFuc3BvcnQuYw0KPiBp
bmRleCBkYzM3MDY2OTAwYTUuLjdjMzhhYmMyNTY3MSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9p
bmZpbmliYW5kL2h3L3VzbmljL3VzbmljX3RyYW5zcG9ydC5jDQo+ICsrKyBiL2RyaXZlcnMvaW5m
aW5pYmFuZC9ody91c25pYy91c25pY190cmFuc3BvcnQuYw0KPiBAQCAtMTc0LDI0ICsxNzQsMjQg
QEAgaW50IHVzbmljX3RyYW5zcG9ydF9zb2NrX2dldF9hZGRyKHN0cnVjdCBzb2NrZXQgKnNvY2ss
IGludCAqcHJvdG8sDQo+ICAJCQkJCXVpbnQzMl90ICphZGRyLCB1aW50MTZfdCAqcG9ydCkNCj4g
IHsNCj4gIAlpbnQgZXJyOw0KPiAtCXN0cnVjdCBzb2NrYWRkcl9pbiBzb2NrX2FkZHI7DQo+ICsJ
dW5pb24gew0KPiArCQlzdHJ1Y3Qgc29ja2FkZHJfc3RvcmFnZSBzdG9yYWdlOw0KPiArCQlzdHJ1
Y3Qgc29ja2FkZHJfaW4gc29ja19hZGRyOw0KPiArCX0gdTsNCj4gIA0KPiAtCWVyciA9IHNvY2st
Pm9wcy0+Z2V0bmFtZShzb2NrLA0KPiAtCQkJCShzdHJ1Y3Qgc29ja2FkZHIgKikmc29ja19hZGRy
LA0KPiAtCQkJCTApOw0KPiArCWVyciA9IHNvY2stPm9wcy0+Z2V0bmFtZShzb2NrLCAmdS5zdG9y
YWdlLCAwKTsNCj4gIAlpZiAoZXJyIDwgMCkNCj4gIAkJcmV0dXJuIGVycjsNCj4gIA0KPiAtCWlm
IChzb2NrX2FkZHIuc2luX2ZhbWlseSAhPSBBRl9JTkVUKQ0KPiArCWlmICh1LnNvY2tfYWRkci5z
aW5fZmFtaWx5ICE9IEFGX0lORVQpDQo+ICAJCXJldHVybiAtRUlOVkFMOw0KPiAgDQo+ICAJaWYg
KHByb3RvKQ0KPiAgCQkqcHJvdG8gPSBzb2NrLT5zay0+c2tfcHJvdG9jb2w7DQo+ICAJaWYgKHBv
cnQpDQo+IC0JCSpwb3J0ID0gbnRvaHMoKChzdHJ1Y3Qgc29ja2FkZHJfaW4gKikmc29ja19hZGRy
KS0+c2luX3BvcnQpOw0KPiArCQkqcG9ydCA9IG50b2hzKHUuc29ja19hZGRyLnNpbl9wb3J0KTsN
Cj4gIAlpZiAoYWRkcikNCj4gLQkJKmFkZHIgPSBudG9obCgoKHN0cnVjdCBzb2NrYWRkcl9pbiAq
KQ0KPiAtCQkJCQkmc29ja19hZGRyKS0+c2luX2FkZHIuc19hZGRyKTsNCj4gKwkJKmFkZHIgPSBu
dG9obCh1LnNvY2tfYWRkci5zaW5fYWRkci5zX2FkZHIpOw0KPiAgDQo+ICAJcmV0dXJuIDA7DQo+
ICB9DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19jbS5oIGIv
ZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfY20uaA0KPiBpbmRleCA3MDExYzhhOGVlN2Iu
LjgwNDU1OWJlODNkNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9z
aXdfY20uaA0KPiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19jbS5oDQo+IEBA
IC05NCwxMiArOTQsMTIgQEAgc3RydWN0IHNpd19jbV93b3JrIHsNCj4gIA0KPiAgc3RhdGljIGlu
bGluZSBpbnQgZ2V0bmFtZV9wZWVyKHN0cnVjdCBzb2NrZXQgKnMsIHN0cnVjdCBzb2NrYWRkcl9z
dG9yYWdlICphKQ0KPiAgew0KPiAtCXJldHVybiBzLT5vcHMtPmdldG5hbWUocywgKHN0cnVjdCBz
b2NrYWRkciAqKWEsIDEpOw0KPiArCXJldHVybiBzLT5vcHMtPmdldG5hbWUocywgYSwgMSk7DQo+
ICB9DQo+ICANCj4gIHN0YXRpYyBpbmxpbmUgaW50IGdldG5hbWVfbG9jYWwoc3RydWN0IHNvY2tl
dCAqcywgc3RydWN0IHNvY2thZGRyX3N0b3JhZ2UgKmEpDQo+ICB7DQo+IC0JcmV0dXJuIHMtPm9w
cy0+Z2V0bmFtZShzLCAoc3RydWN0IHNvY2thZGRyICopYSwgMCk7DQo+ICsJcmV0dXJuIHMtPm9w
cy0+Z2V0bmFtZShzLCBhLCAwKTsNCj4gIH0NCj4gIA0KPiAgc3RhdGljIGlubGluZSBpbnQga3Nv
Y2tfcmVjdihzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBjaGFyICpidWYsIHNpemVfdCBzaXplLA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9pc2RuL21JU0ROL3NvY2tldC5jIGIvZHJpdmVycy9pc2RuL21J
U0ROL3NvY2tldC5jDQo+IGluZGV4IGIyMTViMjhjYWQ3Yi4uMmEzYmNiZjZkMTViIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2lzZG4vbUlTRE4vc29ja2V0LmMNCj4gKysrIGIvZHJpdmVycy9pc2Ru
L21JU0ROL3NvY2tldC5jDQo+IEBAIC01NDksNyArNTQ5LDcgQEAgZGF0YV9zb2NrX2JpbmQoc3Ry
dWN0IHNvY2tldCAqc29jaywgc3RydWN0IHNvY2thZGRyICphZGRyLCBpbnQgYWRkcl9sZW4pDQo+
ICB9DQo+ICANCj4gIHN0YXRpYyBpbnQNCj4gLWRhdGFfc29ja19nZXRuYW1lKHN0cnVjdCBzb2Nr
ZXQgKnNvY2ssIHN0cnVjdCBzb2NrYWRkciAqYWRkciwNCj4gK2RhdGFfc29ja19nZXRuYW1lKHN0
cnVjdCBzb2NrZXQgKnNvY2ssIHN0cnVjdCBzb2NrYWRkcl9zdG9yYWdlICphZGRyLA0KPiAgCQkg
IGludCBwZWVyKQ0KPiAgew0KPiAgCXN0cnVjdCBzb2NrYWRkcl9tSVNETgkqbWFkZHIgPSAoc3Ry
dWN0IHNvY2thZGRyX21JU0ROICopIGFkZHI7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9w
cHAvcHBwb2UuYyBiL2RyaXZlcnMvbmV0L3BwcC9wcHBvZS5jDQo+IGluZGV4IDJlYTRmNDg5MGQy
My4uMTM5ZGVmNmE3MTI4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9wcHAvcHBwb2UuYw0K
PiArKysgYi9kcml2ZXJzL25ldC9wcHAvcHBwb2UuYw0KPiBAQCAtNzE3LDggKzcxNyw4IEBAIHN0
YXRpYyBpbnQgcHBwb2VfY29ubmVjdChzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBzdHJ1Y3Qgc29ja2Fk
ZHIgKnVzZXJ2YWRkciwNCj4gIAlnb3RvIGVuZDsNCj4gIH0NCj4gIA0KPiAtc3RhdGljIGludCBw
cHBvZV9nZXRuYW1lKHN0cnVjdCBzb2NrZXQgKnNvY2ssIHN0cnVjdCBzb2NrYWRkciAqdWFkZHIs
DQo+IC0JCSAgaW50IHBlZXIpDQo+ICtzdGF0aWMgaW50IHBwcG9lX2dldG5hbWUoc3RydWN0IHNv
Y2tldCAqc29jaywgc3RydWN0IHNvY2thZGRyX3N0b3JhZ2UgKnVhZGRyLA0KPiArCQkJIGludCBw
ZWVyKQ0KPiAgew0KPiAgCWludCBsZW4gPSBzaXplb2Yoc3RydWN0IHNvY2thZGRyX3BwcG94KTsN
Cj4gIAlzdHJ1Y3Qgc29ja2FkZHJfcHBwb3ggc3A7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25l
dC9wcHAvcHB0cC5jIGIvZHJpdmVycy9uZXQvcHBwL3BwdHAuYw0KPiBpbmRleCA2ODk2ODdiZDI1
NzQuLjZkMDkwMDA4YTM0ZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvcHBwL3BwdHAuYw0K
PiArKysgYi9kcml2ZXJzL25ldC9wcHAvcHB0cC5jDQo+IEBAIC00NzksOCArNDc5LDggQEAgc3Rh
dGljIGludCBwcHRwX2Nvbm5lY3Qoc3RydWN0IHNvY2tldCAqc29jaywgc3RydWN0IHNvY2thZGRy
ICp1c2VydmFkZHIsDQo+ICAJcmV0dXJuIGVycm9yOw0KPiAgfQ0KPiAgDQo+IC1zdGF0aWMgaW50
IHBwdHBfZ2V0bmFtZShzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBzdHJ1Y3Qgc29ja2FkZHIgKnVhZGRy
LA0KPiAtCWludCBwZWVyKQ0KPiArc3RhdGljIGludCBwcHRwX2dldG5hbWUoc3RydWN0IHNvY2tl
dCAqc29jaywgc3RydWN0IHNvY2thZGRyX3N0b3JhZ2UgKnVhZGRyLA0KPiArCQkJaW50IHBlZXIp
DQo+ICB7DQo+ICAJaW50IGxlbiA9IHNpemVvZihzdHJ1Y3Qgc29ja2FkZHJfcHBwb3gpOw0KPiAg
CXN0cnVjdCBzb2NrYWRkcl9wcHBveCBzcDsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9o
b3N0L3RjcC5jIGIvZHJpdmVycy9udm1lL2hvc3QvdGNwLmMNCj4gaW5kZXggMjhjNzZhM2UxYmQy
Li4wNjg1M2JmMWVlOGMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5jDQo+
ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5jDQo+IEBAIC0yNjQyLDcgKzI2NDIsNyBAQCBz
dGF0aWMgaW50IG52bWVfdGNwX2dldF9hZGRyZXNzKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwsIGNo
YXIgKmJ1ZiwgaW50IHNpemUpDQo+ICANCj4gIAltdXRleF9sb2NrKCZxdWV1ZS0+cXVldWVfbG9j
ayk7DQo+ICANCj4gLQlyZXQgPSBrZXJuZWxfZ2V0c29ja25hbWUocXVldWUtPnNvY2ssIChzdHJ1
Y3Qgc29ja2FkZHIgKikmc3JjX2FkZHIpOw0KPiArCXJldCA9IGtlcm5lbF9nZXRzb2NrbmFtZShx
dWV1ZS0+c29jaywgJnNyY19hZGRyKTsNCj4gIAlpZiAocmV0ID4gMCkgew0KPiAgCQlpZiAobGVu
ID4gMCkNCj4gIAkJCWxlbi0tOyAvKiBzdHJpcCB0cmFpbGluZyBuZXdsaW5lICovDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL252bWUvdGFyZ2V0L3RjcC5jIGIvZHJpdmVycy9udm1lL3RhcmdldC90
Y3AuYw0KPiBpbmRleCBkZjI0MjQ0ZmI4MjAuLjg3MzI0YzcyM2VkNCAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9udm1lL3RhcmdldC90Y3AuYw0KPiArKysgYi9kcml2ZXJzL252bWUvdGFyZ2V0L3Rj
cC5jDQo+IEBAIC0xNjg5LDEzICsxNjg5LDExIEBAIHN0YXRpYyBpbnQgbnZtZXRfdGNwX3NldF9x
dWV1ZV9zb2NrKHN0cnVjdCBudm1ldF90Y3BfcXVldWUgKnF1ZXVlKQ0KPiAgCXN0cnVjdCBpbmV0
X3NvY2sgKmluZXQgPSBpbmV0X3NrKHNvY2stPnNrKTsNCj4gIAlpbnQgcmV0Ow0KPiAgDQo+IC0J
cmV0ID0ga2VybmVsX2dldHNvY2tuYW1lKHNvY2ssDQo+IC0JCShzdHJ1Y3Qgc29ja2FkZHIgKikm
cXVldWUtPnNvY2thZGRyKTsNCj4gKwlyZXQgPSBrZXJuZWxfZ2V0c29ja25hbWUoc29jaywgJnF1
ZXVlLT5zb2NrYWRkcik7DQo+ICAJaWYgKHJldCA8IDApDQo+ICAJCXJldHVybiByZXQ7DQo+ICAN
Cj4gLQlyZXQgPSBrZXJuZWxfZ2V0cGVlcm5hbWUoc29jaywNCj4gLQkJKHN0cnVjdCBzb2NrYWRk
ciAqKSZxdWV1ZS0+c29ja2FkZHJfcGVlcik7DQo+ICsJcmV0ID0ga2VybmVsX2dldHBlZXJuYW1l
KHNvY2ssICZxdWV1ZS0+c29ja2FkZHJfcGVlcik7DQo+ICAJaWYgKHJldCA8IDApDQo+ICAJCXJl
dHVybiByZXQ7DQo+ICANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9pc2NzaV90Y3AuYyBi
L2RyaXZlcnMvc2NzaS9pc2NzaV90Y3AuYw0KPiBpbmRleCBjNzA4ZTEwNTk2MzguLjBhNDU3Zjhh
NTA2MiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zY3NpL2lzY3NpX3RjcC5jDQo+ICsrKyBiL2Ry
aXZlcnMvc2NzaS9pc2NzaV90Y3AuYw0KPiBAQCAtNzk0LDcgKzc5NCw3IEBAIHN0YXRpYyBpbnQg
aXNjc2lfc3dfdGNwX2Nvbm5fZ2V0X3BhcmFtKHN0cnVjdCBpc2NzaV9jbHNfY29ubiAqY2xzX2Nv
bm4sDQo+ICAJc3RydWN0IGlzY3NpX2Nvbm4gKmNvbm4gPSBjbHNfY29ubi0+ZGRfZGF0YTsNCj4g
IAlzdHJ1Y3QgaXNjc2lfc3dfdGNwX2Nvbm4gKnRjcF9zd19jb25uOw0KPiAgCXN0cnVjdCBpc2Nz
aV90Y3BfY29ubiAqdGNwX2Nvbm47DQo+IC0Jc3RydWN0IHNvY2thZGRyX2luNiBhZGRyOw0KPiAr
CXN0cnVjdCBzb2NrYWRkcl9zdG9yYWdlIGFkZHI7DQo+ICAJc3RydWN0IHNvY2tldCAqc29jazsN
Cj4gIAlpbnQgcmM7DQo+ICANCj4gQEAgLTgyNSwxOSArODI1LDE2IEBAIHN0YXRpYyBpbnQgaXNj
c2lfc3dfdGNwX2Nvbm5fZ2V0X3BhcmFtKHN0cnVjdCBpc2NzaV9jbHNfY29ubiAqY2xzX2Nvbm4s
DQo+ICAJCX0NCj4gIA0KPiAgCQlpZiAocGFyYW0gPT0gSVNDU0lfUEFSQU1fTE9DQUxfUE9SVCkN
Cj4gLQkJCXJjID0ga2VybmVsX2dldHNvY2tuYW1lKHNvY2ssDQo+IC0JCQkJCQkoc3RydWN0IHNv
Y2thZGRyICopJmFkZHIpOw0KPiArCQkJcmMgPSBrZXJuZWxfZ2V0c29ja25hbWUoc29jaywgJmFk
ZHIpOw0KPiAgCQllbHNlDQo+IC0JCQlyYyA9IGtlcm5lbF9nZXRwZWVybmFtZShzb2NrLA0KPiAt
CQkJCQkJKHN0cnVjdCBzb2NrYWRkciAqKSZhZGRyKTsNCj4gKwkJCXJjID0ga2VybmVsX2dldHBl
ZXJuYW1lKHNvY2ssICZhZGRyKTsNCj4gIHNvY2tfdW5sb2NrOg0KPiAgCQltdXRleF91bmxvY2so
JnRjcF9zd19jb25uLT5zb2NrX2xvY2spOw0KPiAgCQlpc2NzaV9wdXRfY29ubihjb25uLT5jbHNf
Y29ubik7DQo+ICAJCWlmIChyYyA8IDApDQo+ICAJCQlyZXR1cm4gcmM7DQo+ICANCj4gLQkJcmV0
dXJuIGlzY3NpX2Nvbm5fZ2V0X2FkZHJfcGFyYW0oKHN0cnVjdCBzb2NrYWRkcl9zdG9yYWdlICop
DQo+IC0JCQkJCQkgJmFkZHIsIHBhcmFtLCBidWYpOw0KPiArCQlyZXR1cm4gaXNjc2lfY29ubl9n
ZXRfYWRkcl9wYXJhbSgmYWRkciwgcGFyYW0sIGJ1Zik7DQo+ICAJZGVmYXVsdDoNCj4gIAkJcmV0
dXJuIGlzY3NpX2Nvbm5fZ2V0X3BhcmFtKGNsc19jb25uLCBwYXJhbSwgYnVmKTsNCj4gIAl9DQo+
IEBAIC04NTMsNyArODUwLDcgQEAgc3RhdGljIGludCBpc2NzaV9zd190Y3BfaG9zdF9nZXRfcGFy
YW0oc3RydWN0IFNjc2lfSG9zdCAqc2hvc3QsDQo+ICAJc3RydWN0IGlzY3NpX2Nvbm4gKmNvbm47
DQo+ICAJc3RydWN0IGlzY3NpX3RjcF9jb25uICp0Y3BfY29ubjsNCj4gIAlzdHJ1Y3QgaXNjc2lf
c3dfdGNwX2Nvbm4gKnRjcF9zd19jb25uOw0KPiAtCXN0cnVjdCBzb2NrYWRkcl9pbjYgYWRkcjsN
Cj4gKwlzdHJ1Y3Qgc29ja2FkZHJfc3RvcmFnZSBhZGRyOw0KPiAgCXN0cnVjdCBzb2NrZXQgKnNv
Y2s7DQo+ICAJaW50IHJjOw0KPiAgDQo+IEBAIC04ODMsMTQgKzg4MCwxMyBAQCBzdGF0aWMgaW50
IGlzY3NpX3N3X3RjcF9ob3N0X2dldF9wYXJhbShzdHJ1Y3QgU2NzaV9Ib3N0ICpzaG9zdCwNCj4g
IAkJaWYgKCFzb2NrKQ0KPiAgCQkJcmMgPSAtRU5PVENPTk47DQo+ICAJCWVsc2UNCj4gLQkJCXJj
ID0ga2VybmVsX2dldHNvY2tuYW1lKHNvY2ssIChzdHJ1Y3Qgc29ja2FkZHIgKikmYWRkcik7DQo+
ICsJCQlyYyA9IGtlcm5lbF9nZXRzb2NrbmFtZShzb2NrLCAmYWRkcik7DQo+ICAJCW11dGV4X3Vu
bG9jaygmdGNwX3N3X2Nvbm4tPnNvY2tfbG9jayk7DQo+ICAJCWlzY3NpX3B1dF9jb25uKGNvbm4t
PmNsc19jb25uKTsNCj4gIAkJaWYgKHJjIDwgMCkNCj4gIAkJCXJldHVybiByYzsNCj4gIA0KPiAt
CQlyZXR1cm4gaXNjc2lfY29ubl9nZXRfYWRkcl9wYXJhbSgoc3RydWN0IHNvY2thZGRyX3N0b3Jh
Z2UgKikNCj4gLQkJCQkJCSAmYWRkciwNCj4gKwkJcmV0dXJuIGlzY3NpX2Nvbm5fZ2V0X2FkZHJf
cGFyYW0oJmFkZHIsDQo+ICAJCQkJCQkgKGVudW0gaXNjc2lfcGFyYW0pcGFyYW0sIGJ1Zik7DQo+
ICAJZGVmYXVsdDoNCj4gIAkJcmV0dXJuIGlzY3NpX2hvc3RfZ2V0X3BhcmFtKHNob3N0LCBwYXJh
bSwgYnVmKTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL3Fjb20vcW1pX2ludGVyZmFjZS5j
IGIvZHJpdmVycy9zb2MvcWNvbS9xbWlfaW50ZXJmYWNlLmMNCj4gaW5kZXggYmM2ZDYzNzlkOGIx
Li45NzdjZGYwZjY1OTggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc29jL3Fjb20vcW1pX2ludGVy
ZmFjZS5jDQo+ICsrKyBiL2RyaXZlcnMvc29jL3Fjb20vcW1pX2ludGVyZmFjZS5jDQo+IEBAIC01
OTMsNyArNTkzLDcgQEAgc3RhdGljIHN0cnVjdCBzb2NrZXQgKnFtaV9zb2NrX2NyZWF0ZShzdHJ1
Y3QgcW1pX2hhbmRsZSAqcW1pLA0KPiAgCWlmIChyZXQgPCAwKQ0KPiAgCQlyZXR1cm4gRVJSX1BU
UihyZXQpOw0KPiAgDQo+IC0JcmV0ID0ga2VybmVsX2dldHNvY2tuYW1lKHNvY2ssIChzdHJ1Y3Qg
c29ja2FkZHIgKilzcSk7DQo+ICsJcmV0ID0ga2VybmVsX2dldHNvY2tuYW1lKHNvY2ssIChzdHJ1
Y3Qgc29ja2FkZHJfc3RvcmFnZSAqKXNxKTsNCj4gIAlpZiAocmV0IDwgMCkgew0KPiAgCQlzb2Nr
X3JlbGVhc2Uoc29jayk7DQo+ICAJCXJldHVybiBFUlJfUFRSKHJldCk7DQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3RhcmdldC9pc2NzaS9pc2NzaV90YXJnZXRfbG9naW4uYyBiL2RyaXZlcnMvdGFy
Z2V0L2lzY3NpL2lzY3NpX3RhcmdldF9sb2dpbi5jDQo+IGluZGV4IDkwYjg3MGYyMzRmMC4uOWZj
YmZiYTQzMDM1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3RhcmdldC9pc2NzaS9pc2NzaV90YXJn
ZXRfbG9naW4uYw0KPiArKysgYi9kcml2ZXJzL3RhcmdldC9pc2NzaS9pc2NzaV90YXJnZXRfbG9n
aW4uYw0KPiBAQCAtOTA3LDggKzkwNywxMSBAQCBpbnQgaXNjc2lfdGFyZ2V0X3NldHVwX2xvZ2lu
X3NvY2tldCgNCj4gIGludCBpc2NzaXRfYWNjZXB0X25wKHN0cnVjdCBpc2NzaV9ucCAqbnAsIHN0
cnVjdCBpc2NzaXRfY29ubiAqY29ubikNCj4gIHsNCj4gIAlzdHJ1Y3Qgc29ja2V0ICpuZXdfc29j
aywgKnNvY2sgPSBucC0+bnBfc29ja2V0Ow0KPiAtCXN0cnVjdCBzb2NrYWRkcl9pbiBzb2NrX2lu
Ow0KPiAtCXN0cnVjdCBzb2NrYWRkcl9pbjYgc29ja19pbjY7DQo+ICsJdW5pb24gew0KPiArCQlz
dHJ1Y3Qgc29ja2FkZHJfc3RvcmFnZSBzdG9yYWdlOw0KPiArCQlzdHJ1Y3Qgc29ja2FkZHJfaW4g
c29ja19pbjsNCj4gKwkJc3RydWN0IHNvY2thZGRyX2luNiBzb2NrX2luNjsNCj4gKwl9IHU7DQo+
ICAJaW50IHJjOw0KPiAgDQo+ICAJcmMgPSBrZXJuZWxfYWNjZXB0KHNvY2ssICZuZXdfc29jaywg
MCk7DQo+IEBAIC05MTksNDcgKzkyMiw0MyBAQCBpbnQgaXNjc2l0X2FjY2VwdF9ucChzdHJ1Y3Qg
aXNjc2lfbnAgKm5wLCBzdHJ1Y3QgaXNjc2l0X2Nvbm4gKmNvbm4pDQo+ICAJY29ubi0+bG9naW5f
ZmFtaWx5ID0gbnAtPm5wX3NvY2thZGRyLnNzX2ZhbWlseTsNCj4gIA0KPiAgCWlmIChucC0+bnBf
c29ja2FkZHIuc3NfZmFtaWx5ID09IEFGX0lORVQ2KSB7DQo+IC0JCW1lbXNldCgmc29ja19pbjYs
IDAsIHNpemVvZihzdHJ1Y3Qgc29ja2FkZHJfaW42KSk7DQo+ICsJCW1lbXNldCgmdS5zb2NrX2lu
NiwgMCwgc2l6ZW9mKHN0cnVjdCBzb2NrYWRkcl9pbjYpKTsNCj4gIA0KPiAtCQlyYyA9IGNvbm4t
PnNvY2stPm9wcy0+Z2V0bmFtZShjb25uLT5zb2NrLA0KPiAtCQkJCShzdHJ1Y3Qgc29ja2FkZHIg
Kikmc29ja19pbjYsIDEpOw0KPiArCQlyYyA9IGNvbm4tPnNvY2stPm9wcy0+Z2V0bmFtZShjb25u
LT5zb2NrLCAmdS5zdG9yYWdlLCAxKTsNCj4gIAkJaWYgKHJjID49IDApIHsNCj4gLQkJCWlmICgh
aXB2Nl9hZGRyX3Y0bWFwcGVkKCZzb2NrX2luNi5zaW42X2FkZHIpKSB7DQo+IC0JCQkJbWVtY3B5
KCZjb25uLT5sb2dpbl9zb2NrYWRkciwgJnNvY2tfaW42LCBzaXplb2Yoc29ja19pbjYpKTsNCj4g
KwkJCWlmICghaXB2Nl9hZGRyX3Y0bWFwcGVkKCZ1LnNvY2tfaW42LnNpbjZfYWRkcikpIHsNCj4g
KwkJCQltZW1jcHkoJmNvbm4tPmxvZ2luX3NvY2thZGRyLCAmdS5zb2NrX2luNiwgc2l6ZW9mKHUu
c29ja19pbjYpKTsNCj4gIAkJCX0gZWxzZSB7DQo+ICAJCQkJLyogUHJldGVuZCB0byBiZSBhbiBp
cHY0IHNvY2tldCAqLw0KPiAtCQkJCXNvY2tfaW4uc2luX2ZhbWlseSA9IEFGX0lORVQ7DQo+IC0J
CQkJc29ja19pbi5zaW5fcG9ydCA9IHNvY2tfaW42LnNpbjZfcG9ydDsNCj4gLQkJCQltZW1jcHko
JnNvY2tfaW4uc2luX2FkZHIsICZzb2NrX2luNi5zaW42X2FkZHIuczZfYWRkcjMyWzNdLCA0KTsN
Cj4gLQkJCQltZW1jcHkoJmNvbm4tPmxvZ2luX3NvY2thZGRyLCAmc29ja19pbiwgc2l6ZW9mKHNv
Y2tfaW4pKTsNCj4gKwkJCQl1LnNvY2tfaW4uc2luX2ZhbWlseSA9IEFGX0lORVQ7DQo+ICsJCQkJ
dS5zb2NrX2luLnNpbl9wb3J0ID0gdS5zb2NrX2luNi5zaW42X3BvcnQ7DQo+ICsJCQkJbWVtY3B5
KCZ1LnNvY2tfaW4uc2luX2FkZHIsICZ1LnNvY2tfaW42LnNpbjZfYWRkci5zNl9hZGRyMzJbM10s
IDQpOw0KPiArCQkJCW1lbWNweSgmY29ubi0+bG9naW5fc29ja2FkZHIsICZ1LnNvY2tfaW4sIHNp
emVvZih1LnNvY2tfaW4pKTsNCj4gIAkJCX0NCj4gIAkJfQ0KPiAgDQo+IC0JCXJjID0gY29ubi0+
c29jay0+b3BzLT5nZXRuYW1lKGNvbm4tPnNvY2ssDQo+IC0JCQkJKHN0cnVjdCBzb2NrYWRkciAq
KSZzb2NrX2luNiwgMCk7DQo+ICsJCXJjID0gY29ubi0+c29jay0+b3BzLT5nZXRuYW1lKGNvbm4t
PnNvY2ssICZ1LnN0b3JhZ2UsIDApOw0KPiAgCQlpZiAocmMgPj0gMCkgew0KPiAtCQkJaWYgKCFp
cHY2X2FkZHJfdjRtYXBwZWQoJnNvY2tfaW42LnNpbjZfYWRkcikpIHsNCj4gLQkJCQltZW1jcHko
JmNvbm4tPmxvY2FsX3NvY2thZGRyLCAmc29ja19pbjYsIHNpemVvZihzb2NrX2luNikpOw0KPiAr
CQkJaWYgKCFpcHY2X2FkZHJfdjRtYXBwZWQoJnUuc29ja19pbjYuc2luNl9hZGRyKSkgew0KPiAr
CQkJCW1lbWNweSgmY29ubi0+bG9jYWxfc29ja2FkZHIsICZ1LnNvY2tfaW42LCBzaXplb2YodS5z
b2NrX2luNikpOw0KPiAgCQkJfSBlbHNlIHsNCj4gIAkJCQkvKiBQcmV0ZW5kIHRvIGJlIGFuIGlw
djQgc29ja2V0ICovDQo+IC0JCQkJc29ja19pbi5zaW5fZmFtaWx5ID0gQUZfSU5FVDsNCj4gLQkJ
CQlzb2NrX2luLnNpbl9wb3J0ID0gc29ja19pbjYuc2luNl9wb3J0Ow0KPiAtCQkJCW1lbWNweSgm
c29ja19pbi5zaW5fYWRkciwgJnNvY2tfaW42LnNpbjZfYWRkci5zNl9hZGRyMzJbM10sIDQpOw0K
PiAtCQkJCW1lbWNweSgmY29ubi0+bG9jYWxfc29ja2FkZHIsICZzb2NrX2luLCBzaXplb2Yoc29j
a19pbikpOw0KPiArCQkJCXUuc29ja19pbi5zaW5fZmFtaWx5ID0gQUZfSU5FVDsNCj4gKwkJCQl1
LnNvY2tfaW4uc2luX3BvcnQgPSB1LnNvY2tfaW42LnNpbjZfcG9ydDsNCj4gKwkJCQltZW1jcHko
JnUuc29ja19pbi5zaW5fYWRkciwgJnUuc29ja19pbjYuc2luNl9hZGRyLnM2X2FkZHIzMlszXSwg
NCk7DQo+ICsJCQkJbWVtY3B5KCZjb25uLT5sb2NhbF9zb2NrYWRkciwgJnUuc29ja19pbiwgc2l6
ZW9mKHUuc29ja19pbikpOw0KPiAgCQkJfQ0KPiAgCQl9DQo+ICAJfSBlbHNlIHsNCj4gLQkJbWVt
c2V0KCZzb2NrX2luLCAwLCBzaXplb2Yoc3RydWN0IHNvY2thZGRyX2luKSk7DQo+ICsJCW1lbXNl
dCgmdS5zb2NrX2luLCAwLCBzaXplb2Yoc3RydWN0IHNvY2thZGRyX2luKSk7DQo+ICANCj4gLQkJ
cmMgPSBjb25uLT5zb2NrLT5vcHMtPmdldG5hbWUoY29ubi0+c29jaywNCj4gLQkJCQkoc3RydWN0
IHNvY2thZGRyICopJnNvY2tfaW4sIDEpOw0KPiArCQlyYyA9IGNvbm4tPnNvY2stPm9wcy0+Z2V0
bmFtZShjb25uLT5zb2NrLCAmdS5zdG9yYWdlLCAxKTsNCj4gIAkJaWYgKHJjID49IDApDQo+IC0J
CQltZW1jcHkoJmNvbm4tPmxvZ2luX3NvY2thZGRyLCAmc29ja19pbiwgc2l6ZW9mKHNvY2tfaW4p
KTsNCj4gKwkJCW1lbWNweSgmY29ubi0+bG9naW5fc29ja2FkZHIsICZ1LnNvY2tfaW4sIHNpemVv
Zih1LnNvY2tfaW4pKTsNCj4gIA0KPiAtCQlyYyA9IGNvbm4tPnNvY2stPm9wcy0+Z2V0bmFtZShj
b25uLT5zb2NrLA0KPiAtCQkJCShzdHJ1Y3Qgc29ja2FkZHIgKikmc29ja19pbiwgMCk7DQo+ICsJ
CXJjID0gY29ubi0+c29jay0+b3BzLT5nZXRuYW1lKGNvbm4tPnNvY2ssICZ1LnN0b3JhZ2UsIDAp
Ow0KPiAgCQlpZiAocmMgPj0gMCkNCj4gLQkJCW1lbWNweSgmY29ubi0+bG9jYWxfc29ja2FkZHIs
ICZzb2NrX2luLCBzaXplb2Yoc29ja19pbikpOw0KPiArCQkJbWVtY3B5KCZjb25uLT5sb2NhbF9z
b2NrYWRkciwgJnUuc29ja19pbiwgc2l6ZW9mKHUuc29ja19pbikpOw0KPiAgCX0NCj4gIA0KPiAg
CXJldHVybiAwOw0KPiBkaWZmIC0tZ2l0IGEvZnMvZGxtL2xvd2NvbW1zLmMgYi9mcy9kbG0vbG93
Y29tbXMuYw0KPiBpbmRleCBkZjQwYzNmZDEwNzAuLjdmMjMyOTM2ZTczYyAxMDA2NDQNCj4gLS0t
IGEvZnMvZGxtL2xvd2NvbW1zLmMNCj4gKysrIGIvZnMvZGxtL2xvd2NvbW1zLmMNCj4gQEAgLTk5
Myw3ICs5OTMsNyBAQCBzdGF0aWMgaW50IGFjY2VwdF9mcm9tX3NvY2sodm9pZCkNCj4gIA0KPiAg
CS8qIEdldCB0aGUgY29ubmVjdGVkIHNvY2tldCdzIHBlZXIgKi8NCj4gIAltZW1zZXQoJnBlZXJh
ZGRyLCAwLCBzaXplb2YocGVlcmFkZHIpKTsNCj4gLQlsZW4gPSBuZXdzb2NrLT5vcHMtPmdldG5h
bWUobmV3c29jaywgKHN0cnVjdCBzb2NrYWRkciAqKSZwZWVyYWRkciwgMik7DQo+ICsJbGVuID0g
bmV3c29jay0+b3BzLT5nZXRuYW1lKG5ld3NvY2ssICZwZWVyYWRkciwgMik7DQo+ICAJaWYgKGxl
biA8IDApIHsNCj4gIAkJcmVzdWx0ID0gLUVDT05OQUJPUlRFRDsNCj4gIAkJZ290byBhY2NlcHRf
ZXJyOw0KPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL25mczRjbGllbnQuYyBiL2ZzL25mcy9uZnM0Y2xp
ZW50LmMNCj4gaW5kZXggODMzNzhmNjliMzVlLi5hNzQyODM2N2E1MjYgMTAwNjQ0DQo+IC0tLSBh
L2ZzL25mcy9uZnM0Y2xpZW50LmMNCj4gKysrIGIvZnMvbmZzL25mczRjbGllbnQuYw0KPiBAQCAt
MjQ4LDcgKzI0OCw3IEBAIHN0cnVjdCBuZnNfY2xpZW50ICpuZnM0X2FsbG9jX2NsaWVudChjb25z
dCBzdHJ1Y3QgbmZzX2NsaWVudF9pbml0ZGF0YSAqY2xfaW5pdCkNCj4gIAkJc3RydWN0IHNvY2th
ZGRyX3N0b3JhZ2UgY2JfYWRkcjsNCj4gIAkJc3RydWN0IHNvY2thZGRyICpzYXAgPSAoc3RydWN0
IHNvY2thZGRyICopJmNiX2FkZHI7DQo+ICANCj4gLQkJZXJyID0gcnBjX2xvY2FsYWRkcihjbHAt
PmNsX3JwY2NsaWVudCwgc2FwLCBzaXplb2YoY2JfYWRkcikpOw0KPiArCQllcnIgPSBycGNfbG9j
YWxhZGRyKGNscC0+Y2xfcnBjY2xpZW50LCAmY2JfYWRkciwgc2l6ZW9mKGNiX2FkZHIpKTsNCj4g
IAkJaWYgKGVyciA8IDApDQo+ICAJCQlnb3RvIGVycm9yOw0KPiAgCQllcnIgPSBycGNfbnRvcChz
YXAsIGJ1Ziwgc2l6ZW9mKGJ1ZikpOw0KPiBAQCAtMTM1Miw3ICsxMzUyLDcgQEAgaW50IG5mczRf
dXBkYXRlX3NlcnZlcihzdHJ1Y3QgbmZzX3NlcnZlciAqc2VydmVyLCBjb25zdCBjaGFyICpob3N0
bmFtZSwNCj4gIAlpZiAoZXJyb3IgIT0gMCkNCj4gIAkJcmV0dXJuIGVycm9yOw0KPiAgDQo+IC0J
ZXJyb3IgPSBycGNfbG9jYWxhZGRyKGNsbnQsIGxvY2FsYWRkciwgc2l6ZW9mKGFkZHJlc3MpKTsN
Cj4gKwllcnJvciA9IHJwY19sb2NhbGFkZHIoY2xudCwgJmFkZHJlc3MsIHNpemVvZihhZGRyZXNz
KSk7DQo+ICAJaWYgKGVycm9yICE9IDApDQo+ICAJCXJldHVybiBlcnJvcjsNCj4gIA0KPiBkaWZm
IC0tZ2l0IGEvZnMvb2NmczIvY2x1c3Rlci90Y3AuYyBiL2ZzL29jZnMyL2NsdXN0ZXIvdGNwLmMN
Cj4gaW5kZXggMmI4ZmEzZTc4MmZiLi5iYjhjY2QzYTIyMmYgMTAwNjQ0DQo+IC0tLSBhL2ZzL29j
ZnMyL2NsdXN0ZXIvdGNwLmMNCj4gKysrIGIvZnMvb2NmczIvY2x1c3Rlci90Y3AuYw0KPiBAQCAt
MTc3OSw3ICsxNzc5LDEwIEBAIGludCBvMm5ldF9yZWdpc3Rlcl9oYl9jYWxsYmFja3Modm9pZCkN
Cj4gIHN0YXRpYyBpbnQgbzJuZXRfYWNjZXB0X29uZShzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBpbnQg
Km1vcmUpDQo+ICB7DQo+ICAJaW50IHJldDsNCj4gLQlzdHJ1Y3Qgc29ja2FkZHJfaW4gc2luOw0K
PiArCXVuaW9uIHsNCj4gKwkJc3RydWN0IHNvY2thZGRyX3N0b3JhZ2Ugc3RvcmFnZTsNCj4gKwkJ
c3RydWN0IHNvY2thZGRyX2luIHNpbjsNCj4gKwl9IHU7DQo+ICAJc3RydWN0IHNvY2tldCAqbmV3
X3NvY2sgPSBOVUxMOw0KPiAgCXN0cnVjdCBvMm5tX25vZGUgKm5vZGUgPSBOVUxMOw0KPiAgCXN0
cnVjdCBvMm5tX25vZGUgKmxvY2FsX25vZGUgPSBOVUxMOw0KPiBAQCAtMTgxNSwxNSArMTgxOCwx
NCBAQCBzdGF0aWMgaW50IG8ybmV0X2FjY2VwdF9vbmUoc3RydWN0IHNvY2tldCAqc29jaywgaW50
ICptb3JlKQ0KPiAgCXRjcF9zb2NrX3NldF9ub2RlbGF5KG5ld19zb2NrLT5zayk7DQo+ICAJdGNw
X3NvY2tfc2V0X3VzZXJfdGltZW91dChuZXdfc29jay0+c2ssIE8yTkVUX1RDUF9VU0VSX1RJTUVP
VVQpOw0KPiAgDQo+IC0JcmV0ID0gbmV3X3NvY2stPm9wcy0+Z2V0bmFtZShuZXdfc29jaywgKHN0
cnVjdCBzb2NrYWRkciAqKSAmc2luLCAxKTsNCj4gKwlyZXQgPSBuZXdfc29jay0+b3BzLT5nZXRu
YW1lKG5ld19zb2NrLCAmdS5zdG9yYWdlLCAxKTsNCj4gIAlpZiAocmV0IDwgMCkNCj4gIAkJZ290
byBvdXQ7DQo+ICANCj4gLQlub2RlID0gbzJubV9nZXRfbm9kZV9ieV9pcChzaW4uc2luX2FkZHIu
c19hZGRyKTsNCj4gKwlub2RlID0gbzJubV9nZXRfbm9kZV9ieV9pcCh1LnNpbi5zaW5fYWRkci5z
X2FkZHIpOw0KPiAgCWlmIChub2RlID09IE5VTEwpIHsNCj4gLQkJcHJpbnRrKEtFUk5fTk9USUNF
ICJvMm5ldDogQXR0ZW1wdCB0byBjb25uZWN0IGZyb20gdW5rbm93biAiDQo+IC0JCSAgICAgICAi
bm9kZSBhdCAlcEk0OiVkXG4iLCAmc2luLnNpbl9hZGRyLnNfYWRkciwNCj4gLQkJICAgICAgIG50
b2hzKHNpbi5zaW5fcG9ydCkpOw0KPiArCQlwcmludGsoS0VSTl9OT1RJQ0UgIm8ybmV0OiBBdHRl
bXB0IHRvIGNvbm5lY3QgZnJvbSB1bmtub3duIG5vZGUgYXQgJXBJNDolZFxuIiwNCj4gKwkJICAg
ICAgICZ1LnNpbi5zaW5fYWRkci5zX2FkZHIsIG50b2hzKHUuc2luLnNpbl9wb3J0KSk7DQo+ICAJ
CXJldCA9IC1FSU5WQUw7DQo+ICAJCWdvdG8gb3V0Ow0KPiAgCX0NCj4gQEAgLTE4MzgsOCArMTg0
MCw4IEBAIHN0YXRpYyBpbnQgbzJuZXRfYWNjZXB0X29uZShzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBp
bnQgKm1vcmUpDQo+ICAJCQkJCSYobG9jYWxfbm9kZS0+bmRfaXB2NF9hZGRyZXNzKSwNCj4gIAkJ
CQkJbnRvaHMobG9jYWxfbm9kZS0+bmRfaXB2NF9wb3J0KSwNCj4gIAkJCQkJbm9kZS0+bmRfbmFt
ZSwNCj4gLQkJCQkJbm9kZS0+bmRfbnVtLCAmc2luLnNpbl9hZGRyLnNfYWRkciwNCj4gLQkJCQkJ
bnRvaHMoc2luLnNpbl9wb3J0KSk7DQo+ICsJCQkJCW5vZGUtPm5kX251bSwgJnUuc2luLnNpbl9h
ZGRyLnNfYWRkciwNCj4gKwkJCQkJbnRvaHModS5zaW4uc2luX3BvcnQpKTsNCj4gIAkJcmV0ID0g
LUVJTlZBTDsNCj4gIAkJZ290byBvdXQ7DQo+ICAJfQ0KPiBAQCAtMTg0OSw4ICsxODUxLDggQEAg
c3RhdGljIGludCBvMm5ldF9hY2NlcHRfb25lKHN0cnVjdCBzb2NrZXQgKnNvY2ssIGludCAqbW9y
ZSkNCj4gIAlpZiAoIW8yaGJfY2hlY2tfbm9kZV9oZWFydGJlYXRpbmdfZnJvbV9jYWxsYmFjayhu
b2RlLT5uZF9udW0pKSB7DQo+ICAJCW1sb2coTUxfQ09OTiwgImF0dGVtcHQgdG8gY29ubmVjdCBm
cm9tIG5vZGUgJyVzJyBhdCAiDQo+ICAJCSAgICAgIiVwSTQ6JWQgYnV0IGl0IGlzbid0IGhlYXJ0
YmVhdGluZ1xuIiwNCj4gLQkJICAgICBub2RlLT5uZF9uYW1lLCAmc2luLnNpbl9hZGRyLnNfYWRk
ciwNCj4gLQkJICAgICBudG9ocyhzaW4uc2luX3BvcnQpKTsNCj4gKwkJICAgICBub2RlLT5uZF9u
YW1lLCAmdS5zaW4uc2luX2FkZHIuc19hZGRyLA0KPiArCQkgICAgIG50b2hzKHUuc2luLnNpbl9w
b3J0KSk7DQo+ICAJCXJldCA9IC1FSU5WQUw7DQo+ICAJCWdvdG8gb3V0Ow0KPiAgCX0NCj4gQEAg
LTE4NjYsOCArMTg2OCw4IEBAIHN0YXRpYyBpbnQgbzJuZXRfYWNjZXB0X29uZShzdHJ1Y3Qgc29j
a2V0ICpzb2NrLCBpbnQgKm1vcmUpDQo+ICAJaWYgKHJldCkgew0KPiAgCQlwcmludGsoS0VSTl9O
T1RJQ0UgIm8ybmV0OiBBdHRlbXB0IHRvIGNvbm5lY3QgZnJvbSBub2RlICclcycgIg0KPiAgCQkg
ICAgICAgImF0ICVwSTQ6JWQgYnV0IGl0IGFscmVhZHkgaGFzIGFuIG9wZW4gY29ubmVjdGlvblxu
IiwNCj4gLQkJICAgICAgIG5vZGUtPm5kX25hbWUsICZzaW4uc2luX2FkZHIuc19hZGRyLA0KPiAt
CQkgICAgICAgbnRvaHMoc2luLnNpbl9wb3J0KSk7DQo+ICsJCSAgICAgICBub2RlLT5uZF9uYW1l
LCAmdS5zaW4uc2luX2FkZHIuc19hZGRyLA0KPiArCQkgICAgICAgbnRvaHModS5zaW4uc2luX3Bv
cnQpKTsNCj4gIAkJZ290byBvdXQ7DQo+ICAJfQ0KPiAgDQo+IGRpZmYgLS1naXQgYS9mcy9zbWIv
c2VydmVyL2Nvbm5lY3Rpb24uaCBiL2ZzL3NtYi9zZXJ2ZXIvY29ubmVjdGlvbi5oDQo+IGluZGV4
IDhkZGQ1YTNjN2JhZi4uMzVmYzlmN2NkMGIyIDEwMDY0NA0KPiAtLS0gYS9mcy9zbWIvc2VydmVy
L2Nvbm5lY3Rpb24uaA0KPiArKysgYi9mcy9zbWIvc2VydmVyL2Nvbm5lY3Rpb24uaA0KPiBAQCAt
MTQxLDcgKzE0MSw3IEBAIHN0cnVjdCBrc21iZF90cmFuc3BvcnQgew0KPiAgDQo+ICAjZGVmaW5l
IEtTTUJEX1RDUF9SRUNWX1RJTUVPVVQJKDcgKiBIWikNCj4gICNkZWZpbmUgS1NNQkRfVENQX1NF
TkRfVElNRU9VVAkoNSAqIEhaKQ0KPiAtI2RlZmluZSBLU01CRF9UQ1BfUEVFUl9TT0NLQUREUihj
KQkoKHN0cnVjdCBzb2NrYWRkciAqKSYoKGMpLT5wZWVyX2FkZHIpKQ0KPiArI2RlZmluZSBLU01C
RF9UQ1BfUEVFUl9TT0NLQUREUihjKQkoJigoYyktPnBlZXJfYWRkcikpDQo+ICANCj4gIGV4dGVy
biBzdHJ1Y3QgbGlzdF9oZWFkIGNvbm5fbGlzdDsNCj4gIGV4dGVybiBzdHJ1Y3Qgcndfc2VtYXBo
b3JlIGNvbm5fbGlzdF9sb2NrOw0KPiBkaWZmIC0tZ2l0IGEvZnMvc21iL3NlcnZlci9tZ210L3Ry
ZWVfY29ubmVjdC5jIGIvZnMvc21iL3NlcnZlci9tZ210L3RyZWVfY29ubmVjdC5jDQo+IGluZGV4
IGVjZmM1NzUwODY3MS4uMDZhNTlmYjhkMjViIDEwMDY0NA0KPiAtLS0gYS9mcy9zbWIvc2VydmVy
L21nbXQvdHJlZV9jb25uZWN0LmMNCj4gKysrIGIvZnMvc21iL3NlcnZlci9tZ210L3RyZWVfY29u
bmVjdC5jDQo+IEBAIC0yMiw3ICsyMiw3IEBAIGtzbWJkX3RyZWVfY29ubl9jb25uZWN0KHN0cnVj
dCBrc21iZF93b3JrICp3b3JrLCBjb25zdCBjaGFyICpzaGFyZV9uYW1lKQ0KPiAgCXN0cnVjdCBr
c21iZF90cmVlX2Nvbm5lY3RfcmVzcG9uc2UgKnJlc3AgPSBOVUxMOw0KPiAgCXN0cnVjdCBrc21i
ZF9zaGFyZV9jb25maWcgKnNjOw0KPiAgCXN0cnVjdCBrc21iZF90cmVlX2Nvbm5lY3QgKnRyZWVf
Y29ubiA9IE5VTEw7DQo+IC0Jc3RydWN0IHNvY2thZGRyICpwZWVyX2FkZHI7DQo+ICsJc3RydWN0
IHNvY2thZGRyX3N0b3JhZ2UgKnBlZXJfYWRkcjsNCj4gIAlzdHJ1Y3Qga3NtYmRfY29ubiAqY29u
biA9IHdvcmstPmNvbm47DQo+ICAJc3RydWN0IGtzbWJkX3Nlc3Npb24gKnNlc3MgPSB3b3JrLT5z
ZXNzOw0KPiAgCWludCByZXQ7DQo+IGRpZmYgLS1naXQgYS9mcy9zbWIvc2VydmVyL3RyYW5zcG9y
dF9pcGMuYyBiL2ZzL3NtYi9zZXJ2ZXIvdHJhbnNwb3J0X2lwYy5jDQo+IGluZGV4IDQ4Y2RhMzM1
MGU1YS4uYjI3OWY4Zjc1ZWViIDEwMDY0NA0KPiAtLS0gYS9mcy9zbWIvc2VydmVyL3RyYW5zcG9y
dF9pcGMuYw0KPiArKysgYi9mcy9zbWIvc2VydmVyL3RyYW5zcG9ydF9pcGMuYw0KPiBAQCAtNjQ0
LDcgKzY0NCw3IEBAIHN0cnVjdCBrc21iZF90cmVlX2Nvbm5lY3RfcmVzcG9uc2UgKg0KPiAga3Nt
YmRfaXBjX3RyZWVfY29ubmVjdF9yZXF1ZXN0KHN0cnVjdCBrc21iZF9zZXNzaW9uICpzZXNzLA0K
PiAgCQkJICAgICAgIHN0cnVjdCBrc21iZF9zaGFyZV9jb25maWcgKnNoYXJlLA0KPiAgCQkJICAg
ICAgIHN0cnVjdCBrc21iZF90cmVlX2Nvbm5lY3QgKnRyZWVfY29ubiwNCj4gLQkJCSAgICAgICBz
dHJ1Y3Qgc29ja2FkZHIgKnBlZXJfYWRkcikNCj4gKwkJCSAgICAgICBzdHJ1Y3Qgc29ja2FkZHJf
c3RvcmFnZSAqcGVlcl9hZGRyKQ0KPiAgew0KPiAgCXN0cnVjdCBrc21iZF9pcGNfbXNnICptc2c7
DQo+ICAJc3RydWN0IGtzbWJkX3RyZWVfY29ubmVjdF9yZXF1ZXN0ICpyZXE7DQo+IEBAIC02NzEs
NyArNjcxLDcgQEAga3NtYmRfaXBjX3RyZWVfY29ubmVjdF9yZXF1ZXN0KHN0cnVjdCBrc21iZF9z
ZXNzaW9uICpzZXNzLA0KPiAgCXN0cnNjcHkocmVxLT5zaGFyZSwgc2hhcmUtPm5hbWUsIEtTTUJE
X1JFUV9NQVhfU0hBUkVfTkFNRSk7DQo+ICAJc25wcmludGYocmVxLT5wZWVyX2FkZHIsIHNpemVv
ZihyZXEtPnBlZXJfYWRkciksICIlcElTIiwgcGVlcl9hZGRyKTsNCj4gIA0KPiAtCWlmIChwZWVy
X2FkZHItPnNhX2ZhbWlseSA9PSBBRl9JTkVUNikNCj4gKwlpZiAocGVlcl9hZGRyLT5zc19mYW1p
bHkgPT0gQUZfSU5FVDYpDQo+ICAJCXJlcS0+ZmxhZ3MgfD0gS1NNQkRfVFJFRV9DT05OX0ZMQUdf
UkVRVUVTVF9JUFY2Ow0KPiAgCWlmICh0ZXN0X3Nlc3Npb25fZmxhZyhzZXNzLCBDSUZEU19TRVNT
SU9OX0ZMQUdfU01CMikpDQo+ICAJCXJlcS0+ZmxhZ3MgfD0gS1NNQkRfVFJFRV9DT05OX0ZMQUdf
UkVRVUVTVF9TTUIyOw0KPiBkaWZmIC0tZ2l0IGEvZnMvc21iL3NlcnZlci90cmFuc3BvcnRfaXBj
LmggYi9mcy9zbWIvc2VydmVyL3RyYW5zcG9ydF9pcGMuaA0KPiBpbmRleCBkOWI2NzM3ZjhjZDAu
Ljg0MGI5YjFjNTZmNiAxMDA2NDQNCj4gLS0tIGEvZnMvc21iL3NlcnZlci90cmFuc3BvcnRfaXBj
LmgNCj4gKysrIGIvZnMvc21iL3NlcnZlci90cmFuc3BvcnRfaXBjLmgNCj4gQEAgLTE4LDEzICsx
OCwxMyBAQCBrc21iZF9pcGNfbG9naW5fcmVxdWVzdF9leHQoY29uc3QgY2hhciAqYWNjb3VudCk7
DQo+ICBzdHJ1Y3Qga3NtYmRfc2Vzc2lvbjsNCj4gIHN0cnVjdCBrc21iZF9zaGFyZV9jb25maWc7
DQo+ICBzdHJ1Y3Qga3NtYmRfdHJlZV9jb25uZWN0Ow0KPiAtc3RydWN0IHNvY2thZGRyOw0KPiAr
c3RydWN0IF9fa2VybmVsX3NvY2thZGRyX3N0b3JhZ2U7DQo+ICANCj4gIHN0cnVjdCBrc21iZF90
cmVlX2Nvbm5lY3RfcmVzcG9uc2UgKg0KPiAga3NtYmRfaXBjX3RyZWVfY29ubmVjdF9yZXF1ZXN0
KHN0cnVjdCBrc21iZF9zZXNzaW9uICpzZXNzLA0KPiAgCQkJICAgICAgIHN0cnVjdCBrc21iZF9z
aGFyZV9jb25maWcgKnNoYXJlLA0KPiAgCQkJICAgICAgIHN0cnVjdCBrc21iZF90cmVlX2Nvbm5l
Y3QgKnRyZWVfY29ubiwNCj4gLQkJCSAgICAgICBzdHJ1Y3Qgc29ja2FkZHIgKnBlZXJfYWRkcik7
DQo+ICsJCQkgICAgICAgc3RydWN0IF9fa2VybmVsX3NvY2thZGRyX3N0b3JhZ2UgKnBlZXJfYWRk
cik7DQo+ICBpbnQga3NtYmRfaXBjX3RyZWVfZGlzY29ubmVjdF9yZXF1ZXN0KHVuc2lnbmVkIGxv
bmcgbG9uZyBzZXNzaW9uX2lkLA0KPiAgCQkJCSAgICAgIHVuc2lnbmVkIGxvbmcgbG9uZyBjb25u
ZWN0X2lkKTsNCj4gIGludCBrc21iZF9pcGNfbG9nb3V0X3JlcXVlc3QoY29uc3QgY2hhciAqYWNj
b3VudCwgaW50IGZsYWdzKTsNCj4gZGlmZiAtLWdpdCBhL2ZzL3NtYi9zZXJ2ZXIvdHJhbnNwb3J0
X3RjcC5jIGIvZnMvc21iL3NlcnZlci90cmFuc3BvcnRfdGNwLmMNCj4gaW5kZXggMGQ5MDA3Mjg1
ZTMwLi43YWIxMDMxZTU1NGIgMTAwNjQ0DQo+IC0tLSBhL2ZzL3NtYi9zZXJ2ZXIvdHJhbnNwb3J0
X3RjcC5jDQo+ICsrKyBiL2ZzL3NtYi9zZXJ2ZXIvdHJhbnNwb3J0X3RjcC5jDQo+IEBAIC0xNjAs
OSArMTYwLDkgQEAgc3RhdGljIHN0cnVjdCBrdmVjICpnZXRfY29ubl9pb3ZlYyhzdHJ1Y3QgdGNw
X3RyYW5zcG9ydCAqdCwgdW5zaWduZWQgaW50IG5yX3NlZ3MNCj4gIAlyZXR1cm4gbmV3X2lvdjsN
Cj4gIH0NCj4gIA0KPiAtc3RhdGljIHVuc2lnbmVkIHNob3J0IGtzbWJkX3RjcF9nZXRfcG9ydChj
b25zdCBzdHJ1Y3Qgc29ja2FkZHIgKnNhKQ0KPiArc3RhdGljIHVuc2lnbmVkIHNob3J0IGtzbWJk
X3RjcF9nZXRfcG9ydChjb25zdCBzdHJ1Y3Qgc29ja2FkZHJfc3RvcmFnZSAqc2EpDQo+ICB7DQo+
IC0Jc3dpdGNoIChzYS0+c2FfZmFtaWx5KSB7DQo+ICsJc3dpdGNoIChzYS0+c3NfZmFtaWx5KSB7
DQo+ICAJY2FzZSBBRl9JTkVUOg0KPiAgCQlyZXR1cm4gbnRvaHMoKChzdHJ1Y3Qgc29ja2FkZHJf
aW4gKilzYSktPnNpbl9wb3J0KTsNCj4gIAljYXNlIEFGX0lORVQ2Og0KPiBAQCAtMTgyLDcgKzE4
Miw3IEBAIHN0YXRpYyB1bnNpZ25lZCBzaG9ydCBrc21iZF90Y3BfZ2V0X3BvcnQoY29uc3Qgc3Ry
dWN0IHNvY2thZGRyICpzYSkNCj4gICAqLw0KPiAgc3RhdGljIGludCBrc21iZF90Y3BfbmV3X2Nv
bm5lY3Rpb24oc3RydWN0IHNvY2tldCAqY2xpZW50X3NrKQ0KPiAgew0KPiAtCXN0cnVjdCBzb2Nr
YWRkciAqY3NpbjsNCj4gKwlzdHJ1Y3Qgc29ja2FkZHJfc3RvcmFnZSAqY3NpbjsNCj4gIAlpbnQg
cmMgPSAwOw0KPiAgCXN0cnVjdCB0Y3BfdHJhbnNwb3J0ICp0Ow0KPiAgCXN0cnVjdCB0YXNrX3N0
cnVjdCAqaGFuZGxlcjsNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbmV0LmggYi9pbmNs
dWRlL2xpbnV4L25ldC5oDQo+IGluZGV4IGI3NWJjNTM0YzFiMy4uZTMxYmFhM2ZiMzYwIDEwMDY0
NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L25ldC5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvbmV0
LmgNCj4gQEAgLTE3NSw3ICsxNzUsNyBAQCBzdHJ1Y3QgcHJvdG9fb3BzIHsNCj4gIAkJCQkgICAg
ICBzdHJ1Y3Qgc29ja2V0ICpuZXdzb2NrLA0KPiAgCQkJCSAgICAgIHN0cnVjdCBwcm90b19hY2Nl
cHRfYXJnICphcmcpOw0KPiAgCWludAkJKCpnZXRuYW1lKSAgIChzdHJ1Y3Qgc29ja2V0ICpzb2Nr
LA0KPiAtCQkJCSAgICAgIHN0cnVjdCBzb2NrYWRkciAqYWRkciwNCj4gKwkJCQkgICAgICBzdHJ1
Y3Qgc29ja2FkZHJfc3RvcmFnZSAqYWRkciwNCj4gIAkJCQkgICAgICBpbnQgcGVlcik7DQo+ICAJ
X19wb2xsX3QJKCpwb2xsKQkgICAgIChzdHJ1Y3QgZmlsZSAqZmlsZSwgc3RydWN0IHNvY2tldCAq
c29jaywNCj4gIAkJCQkgICAgICBzdHJ1Y3QgcG9sbF90YWJsZV9zdHJ1Y3QgKndhaXQpOw0KPiBA
QCAtMzUzLDggKzM1Myw4IEBAIGludCBrZXJuZWxfbGlzdGVuKHN0cnVjdCBzb2NrZXQgKnNvY2ss
IGludCBiYWNrbG9nKTsNCj4gIGludCBrZXJuZWxfYWNjZXB0KHN0cnVjdCBzb2NrZXQgKnNvY2ss
IHN0cnVjdCBzb2NrZXQgKipuZXdzb2NrLCBpbnQgZmxhZ3MpOw0KPiAgaW50IGtlcm5lbF9jb25u
ZWN0KHN0cnVjdCBzb2NrZXQgKnNvY2ssIHN0cnVjdCBzb2NrYWRkciAqYWRkciwgaW50IGFkZHJs
ZW4sDQo+ICAJCSAgIGludCBmbGFncyk7DQo+IC1pbnQga2VybmVsX2dldHNvY2tuYW1lKHN0cnVj
dCBzb2NrZXQgKnNvY2ssIHN0cnVjdCBzb2NrYWRkciAqYWRkcik7DQo+IC1pbnQga2VybmVsX2dl
dHBlZXJuYW1lKHN0cnVjdCBzb2NrZXQgKnNvY2ssIHN0cnVjdCBzb2NrYWRkciAqYWRkcik7DQo+
ICtpbnQga2VybmVsX2dldHNvY2tuYW1lKHN0cnVjdCBzb2NrZXQgKnNvY2ssIHN0cnVjdCBzb2Nr
YWRkcl9zdG9yYWdlICphZGRyKTsNCj4gK2ludCBrZXJuZWxfZ2V0cGVlcm5hbWUoc3RydWN0IHNv
Y2tldCAqc29jaywgc3RydWN0IHNvY2thZGRyX3N0b3JhZ2UgKmFkZHIpOw0KPiAgaW50IGtlcm5l
bF9zb2NrX3NodXRkb3duKHN0cnVjdCBzb2NrZXQgKnNvY2ssIGVudW0gc29ja19zaHV0ZG93bl9j
bWQgaG93KTsNCj4gIA0KPiAgLyogUm91dGluZSByZXR1cm5zIHRoZSBJUCBvdmVyaGVhZCBpbXBv
c2VkIGJ5IGEgKGNhbGxlci1wcm90ZWN0ZWQpIHNvY2tldC4gKi8NCj4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvbGludXgvc3VucnBjL2NsbnQuaCBiL2luY2x1ZGUvbGludXgvc3VucnBjL2NsbnQuaA0K
PiBpbmRleCA1MzIxNTg1Yzc3OGYuLjhmMjljZWRlNGZmMyAxMDA2NDQNCj4gLS0tIGEvaW5jbHVk
ZS9saW51eC9zdW5ycGMvY2xudC5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvc3VucnBjL2NsbnQu
aA0KPiBAQCAtMjIzLDggKzIyMyw4IEBAIHVuc2lnbmVkIGludAlycGNfbnVtX2JjX3Nsb3RzKHN0
cnVjdCBycGNfY2xudCAqKTsNCj4gIHZvaWQJCXJwY19mb3JjZV9yZWJpbmQoc3RydWN0IHJwY19j
bG50ICopOw0KPiAgc2l6ZV90CQlycGNfcGVlcmFkZHIoc3RydWN0IHJwY19jbG50ICosIHN0cnVj
dCBzb2NrYWRkciAqLCBzaXplX3QpOw0KPiAgY29uc3QgY2hhcgkqcnBjX3BlZXJhZGRyMnN0cihz
dHJ1Y3QgcnBjX2NsbnQgKiwgZW51bSBycGNfZGlzcGxheV9mb3JtYXRfdCk7DQo+IC1pbnQJCXJw
Y19sb2NhbGFkZHIoc3RydWN0IHJwY19jbG50ICosIHN0cnVjdCBzb2NrYWRkciAqLCBzaXplX3Qp
Ow0KPiAtDQo+ICtpbnQJCXJwY19sb2NhbGFkZHIoc3RydWN0IHJwY19jbG50ICpjbG50LCBzdHJ1
Y3Qgc29ja2FkZHJfc3RvcmFnZSAqYnVmLA0KPiArCQkJICAgICAgc2l6ZV90IGJ1Zmxlbik7DQo+
ICBpbnQgCQlycGNfY2xudF9pdGVyYXRlX2Zvcl9lYWNoX3hwcnQoc3RydWN0IHJwY19jbG50ICpj
bG50LA0KPiAgCQkJaW50ICgqZm4pKHN0cnVjdCBycGNfY2xudCAqLCBzdHJ1Y3QgcnBjX3hwcnQg
Kiwgdm9pZCAqKSwNCj4gIAkJCXZvaWQgKmRhdGEpOw0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9u
ZXQvaW5ldF9jb21tb24uaCBiL2luY2x1ZGUvbmV0L2luZXRfY29tbW9uLmgNCj4gaW5kZXggYzE3
YTY1ODVkMGIwLi4yYmM5NWUwMTcxZTcgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbmV0L2luZXRf
Y29tbW9uLmgNCj4gKysrIGIvaW5jbHVkZS9uZXQvaW5ldF9jb21tb24uaA0KPiBAQCAtNTQsNyAr
NTQsNyBAQCBpbnQgaW5ldF9iaW5kX3NrKHN0cnVjdCBzb2NrICpzaywgc3RydWN0IHNvY2thZGRy
ICp1YWRkciwgaW50IGFkZHJfbGVuKTsNCj4gICNkZWZpbmUgQklORF9OT19DQVBfTkVUX0JJTkRf
U0VSVklDRQkoMSA8PCAzKQ0KPiAgaW50IF9faW5ldF9iaW5kKHN0cnVjdCBzb2NrICpzaywgc3Ry
dWN0IHNvY2thZGRyICp1YWRkciwgaW50IGFkZHJfbGVuLA0KPiAgCQl1MzIgZmxhZ3MpOw0KPiAt
aW50IGluZXRfZ2V0bmFtZShzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBzdHJ1Y3Qgc29ja2FkZHIgKnVh
ZGRyLA0KPiAraW50IGluZXRfZ2V0bmFtZShzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBzdHJ1Y3Qgc29j
a2FkZHJfc3RvcmFnZSAqdWFkZHIsDQo+ICAJCSBpbnQgcGVlcik7DQo+ICBpbnQgaW5ldF9pb2N0
bChzdHJ1Y3Qgc29ja2V0ICpzb2NrLCB1bnNpZ25lZCBpbnQgY21kLCB1bnNpZ25lZCBsb25nIGFy
Zyk7DQo+ICBpbnQgaW5ldF9jdGxfc29ja19jcmVhdGUoc3RydWN0IHNvY2sgKipzaywgdW5zaWdu
ZWQgc2hvcnQgZmFtaWx5LA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9uZXQvaXB2Ni5oIGIvaW5j
bHVkZS9uZXQvaXB2Ni5oDQo+IGluZGV4IDI0OGJmYjI2ZTJhZi4uZTBlZTA3YTg0ODZlIDEwMDY0
NA0KPiAtLS0gYS9pbmNsdWRlL25ldC9pcHY2LmgNCj4gKysrIGIvaW5jbHVkZS9uZXQvaXB2Ni5o
DQo+IEBAIC0xMjE0LDcgKzEyMTQsNyBAQCB2b2lkIGluZXQ2X3NvY2tfZGVzdHJ1Y3Qoc3RydWN0
IHNvY2sgKnNrKTsNCj4gIGludCBpbmV0Nl9yZWxlYXNlKHN0cnVjdCBzb2NrZXQgKnNvY2spOw0K
PiAgaW50IGluZXQ2X2JpbmQoc3RydWN0IHNvY2tldCAqc29jaywgc3RydWN0IHNvY2thZGRyICp1
YWRkciwgaW50IGFkZHJfbGVuKTsNCj4gIGludCBpbmV0Nl9iaW5kX3NrKHN0cnVjdCBzb2NrICpz
aywgc3RydWN0IHNvY2thZGRyICp1YWRkciwgaW50IGFkZHJfbGVuKTsNCj4gLWludCBpbmV0Nl9n
ZXRuYW1lKHN0cnVjdCBzb2NrZXQgKnNvY2ssIHN0cnVjdCBzb2NrYWRkciAqdWFkZHIsDQo+ICtp
bnQgaW5ldDZfZ2V0bmFtZShzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBzdHJ1Y3Qgc29ja2FkZHJfc3Rv
cmFnZSAqdWFkZHIsDQo+ICAJCSAgaW50IHBlZXIpOw0KPiAgaW50IGluZXQ2X2lvY3RsKHN0cnVj
dCBzb2NrZXQgKnNvY2ssIHVuc2lnbmVkIGludCBjbWQsIHVuc2lnbmVkIGxvbmcgYXJnKTsNCj4g
IGludCBpbmV0Nl9jb21wYXRfaW9jdGwoc3RydWN0IHNvY2tldCAqc29jaywgdW5zaWduZWQgaW50
IGNtZCwNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbmV0L3NvY2suaCBiL2luY2x1ZGUvbmV0L3Nv
Y2suaA0KPiBpbmRleCA3NDY0ZTlmOWY0N2MuLjY0N2VkY2VkMmE1MSAxMDA2NDQNCj4gLS0tIGEv
aW5jbHVkZS9uZXQvc29jay5oDQo+ICsrKyBiL2luY2x1ZGUvbmV0L3NvY2suaA0KPiBAQCAtMTgz
Nyw3ICsxODM3LDggQEAgaW50IHNvY2tfbm9fYmluZChzdHJ1Y3Qgc29ja2V0ICosIHN0cnVjdCBz
b2NrYWRkciAqLCBpbnQpOw0KPiAgaW50IHNvY2tfbm9fY29ubmVjdChzdHJ1Y3Qgc29ja2V0ICos
IHN0cnVjdCBzb2NrYWRkciAqLCBpbnQsIGludCk7DQo+ICBpbnQgc29ja19ub19zb2NrZXRwYWly
KHN0cnVjdCBzb2NrZXQgKiwgc3RydWN0IHNvY2tldCAqKTsNCj4gIGludCBzb2NrX25vX2FjY2Vw
dChzdHJ1Y3Qgc29ja2V0ICosIHN0cnVjdCBzb2NrZXQgKiwgc3RydWN0IHByb3RvX2FjY2VwdF9h
cmcgKik7DQo+IC1pbnQgc29ja19ub19nZXRuYW1lKHN0cnVjdCBzb2NrZXQgKiwgc3RydWN0IHNv
Y2thZGRyICosIGludCk7DQo+ICtpbnQgc29ja19ub19nZXRuYW1lKHN0cnVjdCBzb2NrZXQgKnNv
Y2ssIHN0cnVjdCBzb2NrYWRkcl9zdG9yYWdlICpzYWRkciwNCj4gKwkJICAgIGludCBwZWVyKTsN
Cj4gIGludCBzb2NrX25vX2lvY3RsKHN0cnVjdCBzb2NrZXQgKiwgdW5zaWduZWQgaW50LCB1bnNp
Z25lZCBsb25nKTsNCj4gIGludCBzb2NrX25vX2xpc3RlbihzdHJ1Y3Qgc29ja2V0ICosIGludCk7
DQo+ICBpbnQgc29ja19ub19zaHV0ZG93bihzdHJ1Y3Qgc29ja2V0ICosIGludCk7DQo+IGRpZmYg
LS1naXQgYS9uZXQvYXBwbGV0YWxrL2RkcC5jIGIvbmV0L2FwcGxldGFsay9kZHAuYw0KPiBpbmRl
eCBiMDY4NjUxOTg0ZmUuLmIwYTUxMzdlOWRjZSAxMDA2NDQNCj4gLS0tIGEvbmV0L2FwcGxldGFs
ay9kZHAuYw0KPiArKysgYi9uZXQvYXBwbGV0YWxrL2RkcC5jDQo+IEBAIC0xMjU4LDcgKzEyNTgs
NyBAQCBzdGF0aWMgaW50IGF0YWxrX2Nvbm5lY3Qoc3RydWN0IHNvY2tldCAqc29jaywgc3RydWN0
IHNvY2thZGRyICp1YWRkciwNCj4gICAqIEZpbmQgdGhlIG5hbWUgb2YgYW4gQXBwbGVUYWxrIHNv
Y2tldC4gSnVzdCBjb3B5IHRoZSByaWdodA0KPiAgICogZmllbGRzIGludG8gdGhlIHNvY2thZGRy
Lg0KPiAgICovDQo+IC1zdGF0aWMgaW50IGF0YWxrX2dldG5hbWUoc3RydWN0IHNvY2tldCAqc29j
aywgc3RydWN0IHNvY2thZGRyICp1YWRkciwNCj4gK3N0YXRpYyBpbnQgYXRhbGtfZ2V0bmFtZShz
dHJ1Y3Qgc29ja2V0ICpzb2NrLCBzdHJ1Y3Qgc29ja2FkZHJfc3RvcmFnZSAqdWFkZHIsDQo+ICAJ
CQkgaW50IHBlZXIpDQo+ICB7DQo+ICAJc3RydWN0IHNvY2thZGRyX2F0IHNhdDsNCj4gZGlmZiAt
LWdpdCBhL25ldC9hdG0vcHZjLmMgYi9uZXQvYXRtL3B2Yy5jDQo+IGluZGV4IDY2ZDlhOWJkNTg5
Ni4uODk3YjgyZGU3YTViIDEwMDY0NA0KPiAtLS0gYS9uZXQvYXRtL3B2Yy5jDQo+ICsrKyBiL25l
dC9hdG0vcHZjLmMNCj4gQEAgLTg2LDcgKzg2LDcgQEAgc3RhdGljIGludCBwdmNfZ2V0c29ja29w
dChzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBpbnQgbGV2ZWwsIGludCBvcHRuYW1lLA0KPiAgCXJldHVy
biBlcnJvcjsNCj4gIH0NCj4gIA0KPiAtc3RhdGljIGludCBwdmNfZ2V0bmFtZShzdHJ1Y3Qgc29j
a2V0ICpzb2NrLCBzdHJ1Y3Qgc29ja2FkZHIgKnNvY2thZGRyLA0KPiArc3RhdGljIGludCBwdmNf
Z2V0bmFtZShzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBzdHJ1Y3Qgc29ja2FkZHJfc3RvcmFnZSAqc29j
a2FkZHIsDQo+ICAJCSAgICAgICBpbnQgcGVlcikNCj4gIHsNCj4gIAlzdHJ1Y3Qgc29ja2FkZHJf
YXRtcHZjICphZGRyOw0KPiBkaWZmIC0tZ2l0IGEvbmV0L2F0bS9zdmMuYyBiL25ldC9hdG0vc3Zj
LmMNCj4gaW5kZXggZjgxMzdhZTY5M2IwLi5iMDJmNTgzM2NjOWEgMTAwNjQ0DQo+IC0tLSBhL25l
dC9hdG0vc3ZjLmMNCj4gKysrIGIvbmV0L2F0bS9zdmMuYw0KPiBAQCAtNDIzLDcgKzQyMyw3IEBA
IHN0YXRpYyBpbnQgc3ZjX2FjY2VwdChzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBzdHJ1Y3Qgc29ja2V0
ICpuZXdzb2NrLA0KPiAgCXJldHVybiBlcnJvcjsNCj4gIH0NCj4gIA0KPiAtc3RhdGljIGludCBz
dmNfZ2V0bmFtZShzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBzdHJ1Y3Qgc29ja2FkZHIgKnNvY2thZGRy
LA0KPiArc3RhdGljIGludCBzdmNfZ2V0bmFtZShzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBzdHJ1Y3Qg
c29ja2FkZHJfc3RvcmFnZSAqc29ja2FkZHIsDQo+ICAJCSAgICAgICBpbnQgcGVlcikNCj4gIHsN
Cj4gIAlzdHJ1Y3Qgc29ja2FkZHJfYXRtc3ZjICphZGRyOw0KPiBkaWZmIC0tZ2l0IGEvbmV0L2F4
MjUvYWZfYXgyNS5jIGIvbmV0L2F4MjUvYWZfYXgyNS5jDQo+IGluZGV4IGQ2ZjlmYWUwNmE5ZC4u
ODJlZGQ5ZDhhOGY2IDEwMDY0NA0KPiAtLS0gYS9uZXQvYXgyNS9hZl9heDI1LmMNCj4gKysrIGIv
bmV0L2F4MjUvYWZfYXgyNS5jDQo+IEBAIC0xNDQ3LDggKzE0NDcsOCBAQCBzdGF0aWMgaW50IGF4
MjVfYWNjZXB0KHN0cnVjdCBzb2NrZXQgKnNvY2ssIHN0cnVjdCBzb2NrZXQgKm5ld3NvY2ssDQo+
ICAJcmV0dXJuIGVycjsNCj4gIH0NCj4gIA0KPiAtc3RhdGljIGludCBheDI1X2dldG5hbWUoc3Ry
dWN0IHNvY2tldCAqc29jaywgc3RydWN0IHNvY2thZGRyICp1YWRkciwNCj4gLQlpbnQgcGVlcikN
Cj4gK3N0YXRpYyBpbnQgYXgyNV9nZXRuYW1lKHN0cnVjdCBzb2NrZXQgKnNvY2ssIHN0cnVjdCBz
b2NrYWRkcl9zdG9yYWdlICp1YWRkciwNCj4gKwkJCWludCBwZWVyKQ0KPiAgew0KPiAgCXN0cnVj
dCBmdWxsX3NvY2thZGRyX2F4MjUgKmZzYSA9IChzdHJ1Y3QgZnVsbF9zb2NrYWRkcl9heDI1ICop
dWFkZHI7DQo+ICAJc3RydWN0IHNvY2sgKnNrID0gc29jay0+c2s7DQo+IGRpZmYgLS1naXQgYS9u
ZXQvYmx1ZXRvb3RoL2hjaV9zb2NrLmMgYi9uZXQvYmx1ZXRvb3RoL2hjaV9zb2NrLmMNCj4gaW5k
ZXggMjI3MmUxODQ5ZWJkLi4zZmU4NDQ0NjBmYzQgMTAwNjQ0DQo+IC0tLSBhL25ldC9ibHVldG9v
dGgvaGNpX3NvY2suYw0KPiArKysgYi9uZXQvYmx1ZXRvb3RoL2hjaV9zb2NrLmMNCj4gQEAgLTE0
NzgsNyArMTQ3OCw3IEBAIHN0YXRpYyBpbnQgaGNpX3NvY2tfYmluZChzdHJ1Y3Qgc29ja2V0ICpz
b2NrLCBzdHJ1Y3Qgc29ja2FkZHIgKmFkZHIsDQo+ICAJcmV0dXJuIGVycjsNCj4gIH0NCj4gIA0K
PiAtc3RhdGljIGludCBoY2lfc29ja19nZXRuYW1lKHN0cnVjdCBzb2NrZXQgKnNvY2ssIHN0cnVj
dCBzb2NrYWRkciAqYWRkciwNCj4gK3N0YXRpYyBpbnQgaGNpX3NvY2tfZ2V0bmFtZShzdHJ1Y3Qg
c29ja2V0ICpzb2NrLCBzdHJ1Y3Qgc29ja2FkZHJfc3RvcmFnZSAqYWRkciwNCj4gIAkJCSAgICBp
bnQgcGVlcikNCj4gIHsNCj4gIAlzdHJ1Y3Qgc29ja2FkZHJfaGNpICpoYWRkciA9IChzdHJ1Y3Qg
c29ja2FkZHJfaGNpICopYWRkcjsNCj4gZGlmZiAtLWdpdCBhL25ldC9ibHVldG9vdGgvaXNvLmMg
Yi9uZXQvYmx1ZXRvb3RoL2lzby5jDQo+IGluZGV4IDFiNDBmZDJiMmYwMi4uMzc2OTYyNDdiOWE4
IDEwMDY0NA0KPiAtLS0gYS9uZXQvYmx1ZXRvb3RoL2lzby5jDQo+ICsrKyBiL25ldC9ibHVldG9v
dGgvaXNvLmMNCj4gQEAgLTEyNzMsMTUgKzEyNzMsMTUgQEAgc3RhdGljIGludCBpc29fc29ja19h
Y2NlcHQoc3RydWN0IHNvY2tldCAqc29jaywgc3RydWN0IHNvY2tldCAqbmV3c29jaywNCj4gIAly
ZXR1cm4gZXJyOw0KPiAgfQ0KPiAgDQo+IC1zdGF0aWMgaW50IGlzb19zb2NrX2dldG5hbWUoc3Ry
dWN0IHNvY2tldCAqc29jaywgc3RydWN0IHNvY2thZGRyICphZGRyLA0KPiAtCQkJICAgIGludCBw
ZWVyKQ0KPiArc3RhdGljIGludCBpc29fc29ja19nZXRuYW1lKHN0cnVjdCBzb2NrZXQgKnNvY2ss
DQo+ICsJCQkgICAgc3RydWN0IHNvY2thZGRyX3N0b3JhZ2UgKmFkZHIsIGludCBwZWVyKQ0KPiAg
ew0KPiAgCXN0cnVjdCBzb2NrYWRkcl9pc28gKnNhID0gKHN0cnVjdCBzb2NrYWRkcl9pc28gKilh
ZGRyOw0KPiAgCXN0cnVjdCBzb2NrICpzayA9IHNvY2stPnNrOw0KPiAgDQo+ICAJQlRfREJHKCJz
b2NrICVwLCBzayAlcCIsIHNvY2ssIHNrKTsNCj4gIA0KPiAtCWFkZHItPnNhX2ZhbWlseSA9IEFG
X0JMVUVUT09USDsNCj4gKwlzYS0+aXNvX2ZhbWlseSA9IEFGX0JMVUVUT09USDsNCj4gIA0KPiAg
CWlmIChwZWVyKSB7DQo+ICAJCWJhY3B5KCZzYS0+aXNvX2JkYWRkciwgJmlzb19waShzayktPmRz
dCk7DQo+IGRpZmYgLS1naXQgYS9uZXQvYmx1ZXRvb3RoL2wyY2FwX3NvY2suYyBiL25ldC9ibHVl
dG9vdGgvbDJjYXBfc29jay5jDQo+IGluZGV4IDE4ZTg5ZTc2NGYzYi4uNzk5YjI5OTFhYjE3IDEw
MDY0NA0KPiAtLS0gYS9uZXQvYmx1ZXRvb3RoL2wyY2FwX3NvY2suYw0KPiArKysgYi9uZXQvYmx1
ZXRvb3RoL2wyY2FwX3NvY2suYw0KPiBAQCAtMzgyLDggKzM4Miw4IEBAIHN0YXRpYyBpbnQgbDJj
YXBfc29ja19hY2NlcHQoc3RydWN0IHNvY2tldCAqc29jaywgc3RydWN0IHNvY2tldCAqbmV3c29j
aywNCj4gIAlyZXR1cm4gZXJyOw0KPiAgfQ0KPiAgDQo+IC1zdGF0aWMgaW50IGwyY2FwX3NvY2tf
Z2V0bmFtZShzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBzdHJ1Y3Qgc29ja2FkZHIgKmFkZHIsDQo+IC0J
CQkgICAgICBpbnQgcGVlcikNCj4gK3N0YXRpYyBpbnQgbDJjYXBfc29ja19nZXRuYW1lKHN0cnVj
dCBzb2NrZXQgKnNvY2ssDQo+ICsJCQkgICAgICBzdHJ1Y3Qgc29ja2FkZHJfc3RvcmFnZSAqYWRk
ciwgaW50IHBlZXIpDQo+ICB7DQo+ICAJc3RydWN0IHNvY2thZGRyX2wyICpsYSA9IChzdHJ1Y3Qg
c29ja2FkZHJfbDIgKikgYWRkcjsNCj4gIAlzdHJ1Y3Qgc29jayAqc2sgPSBzb2NrLT5zazsNCj4g
QEAgLTM5Nyw3ICszOTcsNyBAQCBzdGF0aWMgaW50IGwyY2FwX3NvY2tfZ2V0bmFtZShzdHJ1Y3Qg
c29ja2V0ICpzb2NrLCBzdHJ1Y3Qgc29ja2FkZHIgKmFkZHIsDQo+ICAJCXJldHVybiAtRU5PVENP
Tk47DQo+ICANCj4gIAltZW1zZXQobGEsIDAsIHNpemVvZihzdHJ1Y3Qgc29ja2FkZHJfbDIpKTsN
Cj4gLQlhZGRyLT5zYV9mYW1pbHkgPSBBRl9CTFVFVE9PVEg7DQo+ICsJbGEtPmwyX2ZhbWlseSA9
IEFGX0JMVUVUT09USDsNCj4gIA0KPiAgCWxhLT5sMl9wc20gPSBjaGFuLT5wc207DQo+ICANCj4g
ZGlmZiAtLWdpdCBhL25ldC9ibHVldG9vdGgvcmZjb21tL3NvY2suYyBiL25ldC9ibHVldG9vdGgv
cmZjb21tL3NvY2suYw0KPiBpbmRleCA0MDc2NmY4MTE5ZWQuLjE2N2E5NWY0NDZkYSAxMDA2NDQN
Cj4gLS0tIGEvbmV0L2JsdWV0b290aC9yZmNvbW0vc29jay5jDQo+ICsrKyBiL25ldC9ibHVldG9v
dGgvcmZjb21tL3NvY2suYw0KPiBAQCAtNTI5LDcgKzUyOSw4IEBAIHN0YXRpYyBpbnQgcmZjb21t
X3NvY2tfYWNjZXB0KHN0cnVjdCBzb2NrZXQgKnNvY2ssIHN0cnVjdCBzb2NrZXQgKm5ld3NvY2ss
DQo+ICAJcmV0dXJuIGVycjsNCj4gIH0NCj4gIA0KPiAtc3RhdGljIGludCByZmNvbW1fc29ja19n
ZXRuYW1lKHN0cnVjdCBzb2NrZXQgKnNvY2ssIHN0cnVjdCBzb2NrYWRkciAqYWRkciwgaW50IHBl
ZXIpDQo+ICtzdGF0aWMgaW50IHJmY29tbV9zb2NrX2dldG5hbWUoc3RydWN0IHNvY2tldCAqc29j
aywgc3RydWN0IHNvY2thZGRyX3N0b3JhZ2UgKmFkZHIsDQo+ICsJCQkgICAgICAgaW50IHBlZXIp
DQo+ICB7DQo+ICAJc3RydWN0IHNvY2thZGRyX3JjICpzYSA9IChzdHJ1Y3Qgc29ja2FkZHJfcmMg
KikgYWRkcjsNCj4gIAlzdHJ1Y3Qgc29jayAqc2sgPSBzb2NrLT5zazsNCj4gZGlmZiAtLWdpdCBh
L25ldC9ibHVldG9vdGgvc2NvLmMgYi9uZXQvYmx1ZXRvb3RoL3Njby5jDQo+IGluZGV4IDc4Zjdi
Y2EyNDQ4Ny4uYTgyOGJjMjk5MGQwIDEwMDY0NA0KPiAtLS0gYS9uZXQvYmx1ZXRvb3RoL3Njby5j
DQo+ICsrKyBiL25ldC9ibHVldG9vdGgvc2NvLmMNCj4gQEAgLTc1MCwxNSArNzUwLDE1IEBAIHN0
YXRpYyBpbnQgc2NvX3NvY2tfYWNjZXB0KHN0cnVjdCBzb2NrZXQgKnNvY2ssIHN0cnVjdCBzb2Nr
ZXQgKm5ld3NvY2ssDQo+ICAJcmV0dXJuIGVycjsNCj4gIH0NCj4gIA0KPiAtc3RhdGljIGludCBz
Y29fc29ja19nZXRuYW1lKHN0cnVjdCBzb2NrZXQgKnNvY2ssIHN0cnVjdCBzb2NrYWRkciAqYWRk
ciwNCj4gLQkJCSAgICBpbnQgcGVlcikNCj4gK3N0YXRpYyBpbnQgc2NvX3NvY2tfZ2V0bmFtZShz
dHJ1Y3Qgc29ja2V0ICpzb2NrLA0KPiArCQkJICAgIHN0cnVjdCBzb2NrYWRkcl9zdG9yYWdlICph
ZGRyLCBpbnQgcGVlcikNCj4gIHsNCj4gIAlzdHJ1Y3Qgc29ja2FkZHJfc2NvICpzYSA9IChzdHJ1
Y3Qgc29ja2FkZHJfc2NvICopIGFkZHI7DQo+ICAJc3RydWN0IHNvY2sgKnNrID0gc29jay0+c2s7
DQo+ICANCj4gIAlCVF9EQkcoInNvY2sgJXAsIHNrICVwIiwgc29jaywgc2spOw0KPiAgDQo+IC0J
YWRkci0+c2FfZmFtaWx5ID0gQUZfQkxVRVRPT1RIOw0KPiArCXNhLT5zY29fZmFtaWx5ID0gQUZf
QkxVRVRPT1RIOw0KPiAgDQo+ICAJaWYgKHBlZXIpDQo+ICAJCWJhY3B5KCZzYS0+c2NvX2JkYWRk
ciwgJnNjb19waShzayktPmRzdCk7DQo+IGRpZmYgLS1naXQgYS9uZXQvY2FuL2lzb3RwLmMgYi9u
ZXQvY2FuL2lzb3RwLmMNCj4gaW5kZXggMTYwNDY5MzE1NDJhLi41YWZiODg4ODU1NDggMTAwNjQ0
DQo+IC0tLSBhL25ldC9jYW4vaXNvdHAuYw0KPiArKysgYi9uZXQvY2FuL2lzb3RwLmMNCj4gQEAg
LTEzNTIsNyArMTM1Miw4IEBAIHN0YXRpYyBpbnQgaXNvdHBfYmluZChzdHJ1Y3Qgc29ja2V0ICpz
b2NrLCBzdHJ1Y3Qgc29ja2FkZHIgKnVhZGRyLCBpbnQgbGVuKQ0KPiAgCXJldHVybiBlcnI7DQo+
ICB9DQo+ICANCj4gLXN0YXRpYyBpbnQgaXNvdHBfZ2V0bmFtZShzdHJ1Y3Qgc29ja2V0ICpzb2Nr
LCBzdHJ1Y3Qgc29ja2FkZHIgKnVhZGRyLCBpbnQgcGVlcikNCj4gK3N0YXRpYyBpbnQgaXNvdHBf
Z2V0bmFtZShzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBzdHJ1Y3Qgc29ja2FkZHJfc3RvcmFnZSAqdWFk
ZHIsDQo+ICsJCQkgaW50IHBlZXIpDQo+ICB7DQo+ICAJc3RydWN0IHNvY2thZGRyX2NhbiAqYWRk
ciA9IChzdHJ1Y3Qgc29ja2FkZHJfY2FuICopdWFkZHI7DQo+ICAJc3RydWN0IHNvY2sgKnNrID0g
c29jay0+c2s7DQo+IGRpZmYgLS1naXQgYS9uZXQvY2FuL2oxOTM5L3NvY2tldC5jIGIvbmV0L2Nh
bi9qMTkzOS9zb2NrZXQuYw0KPiBpbmRleCAzMDVkZDcyYzg0NGMuLjY2ZWE4Mjk4MTFhYiAxMDA2
NDQNCj4gLS0tIGEvbmV0L2Nhbi9qMTkzOS9zb2NrZXQuYw0KPiArKysgYi9uZXQvY2FuL2oxOTM5
L3NvY2tldC5jDQo+IEBAIC01OTgsNyArNTk4LDcgQEAgc3RhdGljIHZvaWQgajE5Mzlfc2tfc29j
azJzb2NrYWRkcl9jYW4oc3RydWN0IHNvY2thZGRyX2NhbiAqYWRkciwNCj4gIAl9DQo+ICB9DQo+
ICANCj4gLXN0YXRpYyBpbnQgajE5Mzlfc2tfZ2V0bmFtZShzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBz
dHJ1Y3Qgc29ja2FkZHIgKnVhZGRyLA0KPiArc3RhdGljIGludCBqMTkzOV9za19nZXRuYW1lKHN0
cnVjdCBzb2NrZXQgKnNvY2ssIHN0cnVjdCBzb2NrYWRkcl9zdG9yYWdlICp1YWRkciwNCj4gIAkJ
CSAgICBpbnQgcGVlcikNCj4gIHsNCj4gIAlzdHJ1Y3Qgc29ja2FkZHJfY2FuICphZGRyID0gKHN0
cnVjdCBzb2NrYWRkcl9jYW4gKil1YWRkcjsNCj4gZGlmZiAtLWdpdCBhL25ldC9jYW4vcmF3LmMg
Yi9uZXQvY2FuL3Jhdy5jDQo+IGluZGV4IDI1NWMwYThmMzlkNi4uNTUxYWVjMGUzMjFlIDEwMDY0
NA0KPiAtLS0gYS9uZXQvY2FuL3Jhdy5jDQo+ICsrKyBiL25ldC9jYW4vcmF3LmMNCj4gQEAgLTUz
MCw3ICs1MzAsNyBAQCBzdGF0aWMgaW50IHJhd19iaW5kKHN0cnVjdCBzb2NrZXQgKnNvY2ssIHN0
cnVjdCBzb2NrYWRkciAqdWFkZHIsIGludCBsZW4pDQo+ICAJcmV0dXJuIGVycjsNCj4gIH0NCj4g
IA0KPiAtc3RhdGljIGludCByYXdfZ2V0bmFtZShzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBzdHJ1Y3Qg
c29ja2FkZHIgKnVhZGRyLA0KPiArc3RhdGljIGludCByYXdfZ2V0bmFtZShzdHJ1Y3Qgc29ja2V0
ICpzb2NrLCBzdHJ1Y3Qgc29ja2FkZHJfc3RvcmFnZSAqdWFkZHIsDQo+ICAJCSAgICAgICBpbnQg
cGVlcikNCj4gIHsNCj4gIAlzdHJ1Y3Qgc29ja2FkZHJfY2FuICphZGRyID0gKHN0cnVjdCBzb2Nr
YWRkcl9jYW4gKil1YWRkcjsNCj4gZGlmZiAtLWdpdCBhL25ldC9jb3JlL3NvY2suYyBiL25ldC9j
b3JlL3NvY2suYw0KPiBpbmRleCA3NDcyOWQyMGNkMDAuLmZkNmQ0MjUxMjUzMCAxMDA2NDQNCj4g
LS0tIGEvbmV0L2NvcmUvc29jay5jDQo+ICsrKyBiL25ldC9jb3JlL3NvY2suYw0KPiBAQCAtMTkw
OSw3ICsxOTA5LDcgQEAgaW50IHNrX2dldHNvY2tvcHQoc3RydWN0IHNvY2sgKnNrLCBpbnQgbGV2
ZWwsIGludCBvcHRuYW1lLA0KPiAgCXsNCj4gIAkJc3RydWN0IHNvY2thZGRyX3N0b3JhZ2UgYWRk
cmVzczsNCj4gIA0KPiAtCQlsdiA9IFJFQURfT05DRShzb2NrLT5vcHMpLT5nZXRuYW1lKHNvY2ss
IChzdHJ1Y3Qgc29ja2FkZHIgKikmYWRkcmVzcywgMik7DQo+ICsJCWx2ID0gUkVBRF9PTkNFKHNv
Y2stPm9wcyktPmdldG5hbWUoc29jaywgJmFkZHJlc3MsIDIpOw0KPiAgCQlpZiAobHYgPCAwKQ0K
PiAgCQkJcmV0dXJuIC1FTk9UQ09OTjsNCj4gIAkJaWYgKGx2IDwgbGVuKQ0KPiBAQCAtMzM0OCw3
ICszMzQ4LDcgQEAgaW50IHNvY2tfbm9fYWNjZXB0KHN0cnVjdCBzb2NrZXQgKnNvY2ssIHN0cnVj
dCBzb2NrZXQgKm5ld3NvY2ssDQo+ICB9DQo+ICBFWFBPUlRfU1lNQk9MKHNvY2tfbm9fYWNjZXB0
KTsNCj4gIA0KPiAtaW50IHNvY2tfbm9fZ2V0bmFtZShzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBzdHJ1
Y3Qgc29ja2FkZHIgKnNhZGRyLA0KPiAraW50IHNvY2tfbm9fZ2V0bmFtZShzdHJ1Y3Qgc29ja2V0
ICpzb2NrLCBzdHJ1Y3Qgc29ja2FkZHJfc3RvcmFnZSAqc2FkZHIsDQo+ICAJCSAgICBpbnQgcGVl
cikNCj4gIHsNCj4gIAlyZXR1cm4gLUVPUE5PVFNVUFA7DQo+IGRpZmYgLS1naXQgYS9uZXQvaXB2
NC9hZl9pbmV0LmMgYi9uZXQvaXB2NC9hZl9pbmV0LmMNCj4gaW5kZXggODA5NWU4MmRlODA4Li4x
ZWJlMmViZTlmMjIgMTAwNjQ0DQo+IC0tLSBhL25ldC9pcHY0L2FmX2luZXQuYw0KPiArKysgYi9u
ZXQvaXB2NC9hZl9pbmV0LmMNCj4gQEAgLTc5Miw3ICs3OTIsNyBAQCBFWFBPUlRfU1lNQk9MKGlu
ZXRfYWNjZXB0KTsNCj4gIC8qDQo+ICAgKglUaGlzIGRvZXMgYm90aCBwZWVybmFtZSBhbmQgc29j
a25hbWUuDQo+ICAgKi8NCj4gLWludCBpbmV0X2dldG5hbWUoc3RydWN0IHNvY2tldCAqc29jaywg
c3RydWN0IHNvY2thZGRyICp1YWRkciwNCj4gK2ludCBpbmV0X2dldG5hbWUoc3RydWN0IHNvY2tl
dCAqc29jaywgc3RydWN0IHNvY2thZGRyX3N0b3JhZ2UgKnVhZGRyLA0KPiAgCQkgaW50IHBlZXIp
DQo+ICB7DQo+ICAJc3RydWN0IHNvY2sgKnNrCQk9IHNvY2stPnNrOw0KPiBkaWZmIC0tZ2l0IGEv
bmV0L2lwdjYvYWZfaW5ldDYuYyBiL25ldC9pcHY2L2FmX2luZXQ2LmMNCj4gaW5kZXggZjYwZWM4
YjBmOGVhLi43OGQyOWRiZWRhMWMgMTAwNjQ0DQo+IC0tLSBhL25ldC9pcHY2L2FmX2luZXQ2LmMN
Cj4gKysrIGIvbmV0L2lwdjYvYWZfaW5ldDYuYw0KPiBAQCAtNTE4LDcgKzUxOCw3IEBAIEVYUE9S
VF9TWU1CT0xfR1BMKGluZXQ2X2NsZWFudXBfc29jayk7DQo+ICAvKg0KPiAgICoJVGhpcyBkb2Vz
IGJvdGggcGVlcm5hbWUgYW5kIHNvY2tuYW1lLg0KPiAgICovDQo+IC1pbnQgaW5ldDZfZ2V0bmFt
ZShzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBzdHJ1Y3Qgc29ja2FkZHIgKnVhZGRyLA0KPiAraW50IGlu
ZXQ2X2dldG5hbWUoc3RydWN0IHNvY2tldCAqc29jaywgc3RydWN0IHNvY2thZGRyX3N0b3JhZ2Ug
KnVhZGRyLA0KPiAgCQkgIGludCBwZWVyKQ0KPiAgew0KPiAgCXN0cnVjdCBzb2NrYWRkcl9pbjYg
KnNpbiA9IChzdHJ1Y3Qgc29ja2FkZHJfaW42ICopdWFkZHI7DQo+IGRpZmYgLS1naXQgYS9uZXQv
aXVjdi9hZl9pdWN2LmMgYi9uZXQvaXVjdi9hZl9pdWN2LmMNCj4gaW5kZXggNzkyOWRmMDhkNGUw
Li4yNjEyMzgyZTFhNDggMTAwNjQ0DQo+IC0tLSBhL25ldC9pdWN2L2FmX2l1Y3YuYw0KPiArKysg
Yi9uZXQvaXVjdi9hZl9pdWN2LmMNCj4gQEAgLTg0OCwxNCArODQ4LDE0IEBAIHN0YXRpYyBpbnQg
aXVjdl9zb2NrX2FjY2VwdChzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBzdHJ1Y3Qgc29ja2V0ICpuZXdz
b2NrLA0KPiAgCXJldHVybiBlcnI7DQo+ICB9DQo+ICANCj4gLXN0YXRpYyBpbnQgaXVjdl9zb2Nr
X2dldG5hbWUoc3RydWN0IHNvY2tldCAqc29jaywgc3RydWN0IHNvY2thZGRyICphZGRyLA0KPiAt
CQkJICAgICBpbnQgcGVlcikNCj4gK3N0YXRpYyBpbnQgaXVjdl9zb2NrX2dldG5hbWUoc3RydWN0
IHNvY2tldCAqc29jaywNCj4gKwkJCSAgICAgc3RydWN0IHNvY2thZGRyX3N0b3JhZ2UgKmFkZHIs
IGludCBwZWVyKQ0KPiAgew0KPiAgCURFQ0xBUkVfU09DS0FERFIoc3RydWN0IHNvY2thZGRyX2l1
Y3YgKiwgc2l1Y3YsIGFkZHIpOw0KPiAgCXN0cnVjdCBzb2NrICpzayA9IHNvY2stPnNrOw0KPiAg
CXN0cnVjdCBpdWN2X3NvY2sgKml1Y3YgPSBpdWN2X3NrKHNrKTsNCj4gIA0KPiAtCWFkZHItPnNh
X2ZhbWlseSA9IEFGX0lVQ1Y7DQo+ICsJc2l1Y3YtPnNhX2ZhbWlseSA9IEFGX0lVQ1Y7DQo+ICAN
Cj4gIAlpZiAocGVlcikgew0KPiAgCQltZW1jcHkoc2l1Y3YtPnNpdWN2X3VzZXJfaWQsIGl1Y3Yt
PmRzdF91c2VyX2lkLCA4KTsNCj4gZGlmZiAtLWdpdCBhL25ldC9sMnRwL2wydHBfaXAuYyBiL25l
dC9sMnRwL2wydHBfaXAuYw0KPiBpbmRleCA0YmMyNGZkZGZkNTIuLmVkOTJlYWJiODU1MiAxMDA2
NDQNCj4gLS0tIGEvbmV0L2wydHAvbDJ0cF9pcC5jDQo+ICsrKyBiL25ldC9sMnRwL2wydHBfaXAu
Yw0KPiBAQCAtMzczLDcgKzM3Myw3IEBAIHN0YXRpYyBpbnQgbDJ0cF9pcF9kaXNjb25uZWN0KHN0
cnVjdCBzb2NrICpzaywgaW50IGZsYWdzKQ0KPiAgCXJldHVybiBfX3VkcF9kaXNjb25uZWN0KHNr
LCBmbGFncyk7DQo+ICB9DQo+ICANCj4gLXN0YXRpYyBpbnQgbDJ0cF9pcF9nZXRuYW1lKHN0cnVj
dCBzb2NrZXQgKnNvY2ssIHN0cnVjdCBzb2NrYWRkciAqdWFkZHIsDQo+ICtzdGF0aWMgaW50IGwy
dHBfaXBfZ2V0bmFtZShzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBzdHJ1Y3Qgc29ja2FkZHJfc3RvcmFn
ZSAqdWFkZHIsDQo+ICAJCQkgICBpbnQgcGVlcikNCj4gIHsNCj4gIAlzdHJ1Y3Qgc29jayAqc2sJ
CT0gc29jay0+c2s7DQo+IGRpZmYgLS1naXQgYS9uZXQvbDJ0cC9sMnRwX2lwNi5jIGIvbmV0L2wy
dHAvbDJ0cF9pcDYuYw0KPiBpbmRleCBmNGMxZGEwNzA4MjYuLjU5YTVlNzRiMjU2MSAxMDA2NDQN
Cj4gLS0tIGEvbmV0L2wydHAvbDJ0cF9pcDYuYw0KPiArKysgYi9uZXQvbDJ0cC9sMnRwX2lwNi5j
DQo+IEBAIC00NDMsNyArNDQzLDcgQEAgc3RhdGljIGludCBsMnRwX2lwNl9kaXNjb25uZWN0KHN0
cnVjdCBzb2NrICpzaywgaW50IGZsYWdzKQ0KPiAgCXJldHVybiBfX3VkcF9kaXNjb25uZWN0KHNr
LCBmbGFncyk7DQo+ICB9DQo+ICANCj4gLXN0YXRpYyBpbnQgbDJ0cF9pcDZfZ2V0bmFtZShzdHJ1
Y3Qgc29ja2V0ICpzb2NrLCBzdHJ1Y3Qgc29ja2FkZHIgKnVhZGRyLA0KPiArc3RhdGljIGludCBs
MnRwX2lwNl9nZXRuYW1lKHN0cnVjdCBzb2NrZXQgKnNvY2ssIHN0cnVjdCBzb2NrYWRkcl9zdG9y
YWdlICp1YWRkciwNCj4gIAkJCSAgICBpbnQgcGVlcikNCj4gIHsNCj4gIAlzdHJ1Y3Qgc29ja2Fk
ZHJfbDJ0cGlwNiAqbHNhID0gKHN0cnVjdCBzb2NrYWRkcl9sMnRwaXA2ICopdWFkZHI7DQo+IGRp
ZmYgLS1naXQgYS9uZXQvbDJ0cC9sMnRwX3BwcC5jIGIvbmV0L2wydHAvbDJ0cF9wcHAuYw0KPiBp
bmRleCA1M2JhZjJkZDVkNWQuLmFlMTUzNmVkNWE1YiAxMDA2NDQNCj4gLS0tIGEvbmV0L2wydHAv
bDJ0cF9wcHAuYw0KPiArKysgYi9uZXQvbDJ0cC9sMnRwX3BwcC5jDQo+IEBAIC04ODYsNyArODg2
LDcgQEAgc3RhdGljIGludCBwcHBvbDJ0cF9zZXNzaW9uX2NyZWF0ZShzdHJ1Y3QgbmV0ICpuZXQs
IHN0cnVjdCBsMnRwX3R1bm5lbCAqdHVubmVsLA0KPiAgDQo+ICAvKiBnZXRuYW1lKCkgc3VwcG9y
dC4NCj4gICAqLw0KPiAtc3RhdGljIGludCBwcHBvbDJ0cF9nZXRuYW1lKHN0cnVjdCBzb2NrZXQg
KnNvY2ssIHN0cnVjdCBzb2NrYWRkciAqdWFkZHIsDQo+ICtzdGF0aWMgaW50IHBwcG9sMnRwX2dl
dG5hbWUoc3RydWN0IHNvY2tldCAqc29jaywgc3RydWN0IHNvY2thZGRyX3N0b3JhZ2UgKnVhZGRy
LA0KPiAgCQkJICAgIGludCBwZWVyKQ0KPiAgew0KPiAgCWludCBsZW4gPSAwOw0KPiBkaWZmIC0t
Z2l0IGEvbmV0L2xsYy9hZl9sbGMuYyBiL25ldC9sbGMvYWZfbGxjLmMNCj4gaW5kZXggMDI1OWNk
ZTM5NGJhLi4xMmMwYjE0ZTFlZjYgMTAwNjQ0DQo+IC0tLSBhL25ldC9sbGMvYWZfbGxjLmMNCj4g
KysrIGIvbmV0L2xsYy9hZl9sbGMuYw0KPiBAQCAtMTAyMyw3ICsxMDIzLDcgQEAgc3RhdGljIGlu
dCBsbGNfdWlfc2VuZG1zZyhzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBzdHJ1Y3QgbXNnaGRyICptc2cs
IHNpemVfdCBsZW4pDQo+ICAgKg0KPiAgICoJUmV0dXJuIHRoZSBhZGRyZXNzIGluZm9ybWF0aW9u
IG9mIGEgc29ja2V0Lg0KPiAgICovDQo+IC1zdGF0aWMgaW50IGxsY191aV9nZXRuYW1lKHN0cnVj
dCBzb2NrZXQgKnNvY2ssIHN0cnVjdCBzb2NrYWRkciAqdWFkZHIsDQo+ICtzdGF0aWMgaW50IGxs
Y191aV9nZXRuYW1lKHN0cnVjdCBzb2NrZXQgKnNvY2ssIHN0cnVjdCBzb2NrYWRkcl9zdG9yYWdl
ICp1YWRkciwNCj4gIAkJCSAgaW50IHBlZXIpDQo+ICB7DQo+ICAJc3RydWN0IHNvY2thZGRyX2xs
YyBzbGxjOw0KPiBkaWZmIC0tZ2l0IGEvbmV0L25ldGxpbmsvYWZfbmV0bGluay5jIGIvbmV0L25l
dGxpbmsvYWZfbmV0bGluay5jDQo+IGluZGV4IGY0ZTdiNWU0YmI1OS4uNjRlYzkyOTMxMzZmIDEw
MDY0NA0KPiAtLS0gYS9uZXQvbmV0bGluay9hZl9uZXRsaW5rLmMNCj4gKysrIGIvbmV0L25ldGxp
bmsvYWZfbmV0bGluay5jDQo+IEBAIC0xMTEzLDggKzExMTMsOCBAQCBzdGF0aWMgaW50IG5ldGxp
bmtfY29ubmVjdChzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBzdHJ1Y3Qgc29ja2FkZHIgKmFkZHIsDQo+
ICAJcmV0dXJuIGVycjsNCj4gIH0NCj4gIA0KPiAtc3RhdGljIGludCBuZXRsaW5rX2dldG5hbWUo
c3RydWN0IHNvY2tldCAqc29jaywgc3RydWN0IHNvY2thZGRyICphZGRyLA0KPiAtCQkJICAgaW50
IHBlZXIpDQo+ICtzdGF0aWMgaW50IG5ldGxpbmtfZ2V0bmFtZShzdHJ1Y3Qgc29ja2V0ICpzb2Nr
LA0KPiArCQkJICAgc3RydWN0IHNvY2thZGRyX3N0b3JhZ2UgKmFkZHIsIGludCBwZWVyKQ0KPiAg
ew0KPiAgCXN0cnVjdCBzb2NrICpzayA9IHNvY2stPnNrOw0KPiAgCXN0cnVjdCBuZXRsaW5rX3Nv
Y2sgKm5sayA9IG5sa19zayhzayk7DQo+IGRpZmYgLS1naXQgYS9uZXQvbmV0cm9tL2FmX25ldHJv
bS5jIGIvbmV0L25ldHJvbS9hZl9uZXRyb20uYw0KPiBpbmRleCA2ZWUxNDhmMGU2ZDAuLmY4NDVj
MGE1NmI3NSAxMDA2NDQNCj4gLS0tIGEvbmV0L25ldHJvbS9hZl9uZXRyb20uYw0KPiArKysgYi9u
ZXQvbmV0cm9tL2FmX25ldHJvbS5jDQo+IEBAIC04MzUsOCArODM1LDggQEAgc3RhdGljIGludCBu
cl9hY2NlcHQoc3RydWN0IHNvY2tldCAqc29jaywgc3RydWN0IHNvY2tldCAqbmV3c29jaywNCj4g
IAlyZXR1cm4gZXJyOw0KPiAgfQ0KPiAgDQo+IC1zdGF0aWMgaW50IG5yX2dldG5hbWUoc3RydWN0
IHNvY2tldCAqc29jaywgc3RydWN0IHNvY2thZGRyICp1YWRkciwNCj4gLQlpbnQgcGVlcikNCj4g
K3N0YXRpYyBpbnQgbnJfZ2V0bmFtZShzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBzdHJ1Y3Qgc29ja2Fk
ZHJfc3RvcmFnZSAqdWFkZHIsDQo+ICsJCSAgICAgIGludCBwZWVyKQ0KPiAgew0KPiAgCXN0cnVj
dCBmdWxsX3NvY2thZGRyX2F4MjUgKnNheCA9IChzdHJ1Y3QgZnVsbF9zb2NrYWRkcl9heDI1ICop
dWFkZHI7DQo+ICAJc3RydWN0IHNvY2sgKnNrID0gc29jay0+c2s7DQo+IGRpZmYgLS1naXQgYS9u
ZXQvbmZjL2xsY3Bfc29jay5jIGIvbmV0L25mYy9sbGNwX3NvY2suYw0KPiBpbmRleCA1N2EyZjk3
MDA0ZTEuLjFiYTE5ZTU0MjMyMCAxMDA2NDQNCj4gLS0tIGEvbmV0L25mYy9sbGNwX3NvY2suYw0K
PiArKysgYi9uZXQvbmZjL2xsY3Bfc29jay5jDQo+IEBAIC01MDAsOCArNTAwLDggQEAgc3RhdGlj
IGludCBsbGNwX3NvY2tfYWNjZXB0KHN0cnVjdCBzb2NrZXQgKnNvY2ssIHN0cnVjdCBzb2NrZXQg
Km5ld3NvY2ssDQo+ICAJcmV0dXJuIHJldDsNCj4gIH0NCj4gIA0KPiAtc3RhdGljIGludCBsbGNw
X3NvY2tfZ2V0bmFtZShzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBzdHJ1Y3Qgc29ja2FkZHIgKnVhZGRy
LA0KPiAtCQkJICAgICBpbnQgcGVlcikNCj4gK3N0YXRpYyBpbnQgbGxjcF9zb2NrX2dldG5hbWUo
c3RydWN0IHNvY2tldCAqc29jaywNCj4gKwkJCSAgICAgc3RydWN0IHNvY2thZGRyX3N0b3JhZ2Ug
KnVhZGRyLCBpbnQgcGVlcikNCj4gIHsNCj4gIAlzdHJ1Y3Qgc29jayAqc2sgPSBzb2NrLT5zazsN
Cj4gIAlzdHJ1Y3QgbmZjX2xsY3Bfc29jayAqbGxjcF9zb2NrID0gbmZjX2xsY3Bfc29jayhzayk7
DQo+IGRpZmYgLS1naXQgYS9uZXQvcGFja2V0L2FmX3BhY2tldC5jIGIvbmV0L3BhY2tldC9hZl9w
YWNrZXQuYw0KPiBpbmRleCA4ODZjMGRkNDdiNjYuLjM2NjE0NzY5MjBhZiAxMDA2NDQNCj4gLS0t
IGEvbmV0L3BhY2tldC9hZl9wYWNrZXQuYw0KPiArKysgYi9uZXQvcGFja2V0L2FmX3BhY2tldC5j
DQo+IEBAIC0zNjQwLDI3ICszNjQwLDI4IEBAIHN0YXRpYyBpbnQgcGFja2V0X3JlY3Ztc2coc3Ry
dWN0IHNvY2tldCAqc29jaywgc3RydWN0IG1zZ2hkciAqbXNnLCBzaXplX3QgbGVuLA0KPiAgCXJl
dHVybiBlcnI7DQo+ICB9DQo+ICANCj4gLXN0YXRpYyBpbnQgcGFja2V0X2dldG5hbWVfc3BrdChz
dHJ1Y3Qgc29ja2V0ICpzb2NrLCBzdHJ1Y3Qgc29ja2FkZHIgKnVhZGRyLA0KPiAtCQkJICAgICAg
IGludCBwZWVyKQ0KPiArc3RhdGljIGludCBwYWNrZXRfZ2V0bmFtZV9zcGt0KHN0cnVjdCBzb2Nr
ZXQgKnNvY2ssDQo+ICsJCQkgICAgICAgc3RydWN0IHNvY2thZGRyX3N0b3JhZ2UgKnVhZGRyLCBp
bnQgcGVlcikNCj4gIHsNCj4gKwlzdHJ1Y3Qgc29ja2FkZHIgKmFkZHIgPSAoc3RydWN0IHNvY2th
ZGRyICopdWFkZHI7DQo+ICAJc3RydWN0IG5ldF9kZXZpY2UgKmRldjsNCj4gIAlzdHJ1Y3Qgc29j
ayAqc2sJPSBzb2NrLT5zazsNCj4gIA0KPiAgCWlmIChwZWVyKQ0KPiAgCQlyZXR1cm4gLUVPUE5P
VFNVUFA7DQo+ICANCj4gLQl1YWRkci0+c2FfZmFtaWx5ID0gQUZfUEFDS0VUOw0KPiAtCW1lbXNl
dCh1YWRkci0+c2FfZGF0YSwgMCwgc2l6ZW9mKHVhZGRyLT5zYV9kYXRhX21pbikpOw0KPiArCWFk
ZHItPnNhX2ZhbWlseSA9IEFGX1BBQ0tFVDsNCj4gKwltZW1zZXQoYWRkci0+c2FfZGF0YSwgMCwg
c2l6ZW9mKGFkZHItPnNhX2RhdGFfbWluKSk7DQo+ICAJcmN1X3JlYWRfbG9jaygpOw0KPiAgCWRl
diA9IGRldl9nZXRfYnlfaW5kZXhfcmN1KHNvY2tfbmV0KHNrKSwgUkVBRF9PTkNFKHBrdF9zayhz
ayktPmlmaW5kZXgpKTsNCj4gIAlpZiAoZGV2KQ0KPiAtCQlzdHJzY3B5KHVhZGRyLT5zYV9kYXRh
LCBkZXYtPm5hbWUsIHNpemVvZih1YWRkci0+c2FfZGF0YV9taW4pKTsNCj4gKwkJc3Ryc2NweShh
ZGRyLT5zYV9kYXRhLCBkZXYtPm5hbWUsIHNpemVvZihhZGRyLT5zYV9kYXRhX21pbikpOw0KPiAg
CXJjdV9yZWFkX3VubG9jaygpOw0KPiAgDQo+IC0JcmV0dXJuIHNpemVvZigqdWFkZHIpOw0KPiAr
CXJldHVybiBzaXplb2YoKmFkZHIpOw0KPiAgfQ0KPiAgDQo+IC1zdGF0aWMgaW50IHBhY2tldF9n
ZXRuYW1lKHN0cnVjdCBzb2NrZXQgKnNvY2ssIHN0cnVjdCBzb2NrYWRkciAqdWFkZHIsDQo+ICtz
dGF0aWMgaW50IHBhY2tldF9nZXRuYW1lKHN0cnVjdCBzb2NrZXQgKnNvY2ssIHN0cnVjdCBzb2Nr
YWRkcl9zdG9yYWdlICp1YWRkciwNCj4gIAkJCSAgaW50IHBlZXIpDQo+ICB7DQo+ICAJc3RydWN0
IG5ldF9kZXZpY2UgKmRldjsNCj4gZGlmZiAtLWdpdCBhL25ldC9waG9uZXQvc29ja2V0LmMgYi9u
ZXQvcGhvbmV0L3NvY2tldC5jDQo+IGluZGV4IDVjZTBiM2VlNWRlZi4uNzExYzcwY2MxMTBhIDEw
MDY0NA0KPiAtLS0gYS9uZXQvcGhvbmV0L3NvY2tldC5jDQo+ICsrKyBiL25ldC9waG9uZXQvc29j
a2V0LmMNCj4gQEAgLTMxMSwxNyArMzExLDE3IEBAIHN0YXRpYyBpbnQgcG5fc29ja2V0X2FjY2Vw
dChzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBzdHJ1Y3Qgc29ja2V0ICpuZXdzb2NrLA0KPiAgCXJldHVy
biAwOw0KPiAgfQ0KPiAgDQo+IC1zdGF0aWMgaW50IHBuX3NvY2tldF9nZXRuYW1lKHN0cnVjdCBz
b2NrZXQgKnNvY2ssIHN0cnVjdCBzb2NrYWRkciAqYWRkciwNCj4gLQkJCQlpbnQgcGVlcikNCj4g
K3N0YXRpYyBpbnQgcG5fc29ja2V0X2dldG5hbWUoc3RydWN0IHNvY2tldCAqc29jaywNCj4gKwkJ
CSAgICAgc3RydWN0IHNvY2thZGRyX3N0b3JhZ2UgKnVhZGRyLCBpbnQgcGVlcikNCj4gIHsNCj4g
KwlzdHJ1Y3Qgc29ja2FkZHJfcG4gKmFkZHIgPSAoc3RydWN0IHNvY2thZGRyX3BuICopdWFkZHI7
DQo+ICAJc3RydWN0IHNvY2sgKnNrID0gc29jay0+c2s7DQo+ICAJc3RydWN0IHBuX3NvY2sgKnBu
ID0gcG5fc2soc2spOw0KPiAgDQo+ICAJbWVtc2V0KGFkZHIsIDAsIHNpemVvZihzdHJ1Y3Qgc29j
a2FkZHJfcG4pKTsNCj4gLQlhZGRyLT5zYV9mYW1pbHkgPSBBRl9QSE9ORVQ7DQo+ICsJYWRkci0+
c3BuX2ZhbWlseSA9IEFGX1BIT05FVDsNCj4gIAlpZiAoIXBlZXIpIC8qIFJhY2Ugd2l0aCBiaW5k
KCkgaGVyZSBpcyB1c2VybGFuZCdzIHByb2JsZW0uICovDQo+IC0JCXBuX3NvY2thZGRyX3NldF9v
YmplY3QoKHN0cnVjdCBzb2NrYWRkcl9wbiAqKWFkZHIsDQo+IC0JCQkJCXBuLT5zb2JqZWN0KTsN
Cj4gKwkJcG5fc29ja2FkZHJfc2V0X29iamVjdChhZGRyLCBwbi0+c29iamVjdCk7DQo+ICANCj4g
IAlyZXR1cm4gc2l6ZW9mKHN0cnVjdCBzb2NrYWRkcl9wbik7DQo+ICB9DQo+IGRpZmYgLS1naXQg
YS9uZXQvcXJ0ci9hZl9xcnRyLmMgYi9uZXQvcXJ0ci9hZl9xcnRyLmMNCj4gaW5kZXggMDBjNTFj
ZjY5M2YzLi44MzZjOWE0YTIxMTkgMTAwNjQ0DQo+IC0tLSBhL25ldC9xcnRyL2FmX3FydHIuYw0K
PiArKysgYi9uZXQvcXJ0ci9hZl9xcnRyLmMNCj4gQEAgLTExMTUsNyArMTExNSw3IEBAIHN0YXRp
YyBpbnQgcXJ0cl9jb25uZWN0KHN0cnVjdCBzb2NrZXQgKnNvY2ssIHN0cnVjdCBzb2NrYWRkciAq
c2FkZHIsDQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+ICANCj4gLXN0YXRpYyBpbnQgcXJ0cl9nZXRu
YW1lKHN0cnVjdCBzb2NrZXQgKnNvY2ssIHN0cnVjdCBzb2NrYWRkciAqc2FkZHIsDQo+ICtzdGF0
aWMgaW50IHFydHJfZ2V0bmFtZShzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBzdHJ1Y3Qgc29ja2FkZHJf
c3RvcmFnZSAqc2FkZHIsDQo+ICAJCQlpbnQgcGVlcikNCj4gIHsNCj4gIAlzdHJ1Y3QgcXJ0cl9z
b2NrICppcGMgPSBxcnRyX3NrKHNvY2stPnNrKTsNCj4gZGlmZiAtLWdpdCBhL25ldC9xcnRyL25z
LmMgYi9uZXQvcXJ0ci9ucy5jDQo+IGluZGV4IDNkZTkzNTBjYmYzMC4uMDQwOTk4M2ViOWZiIDEw
MDY0NA0KPiAtLS0gYS9uZXQvcXJ0ci9ucy5jDQo+ICsrKyBiL25ldC9xcnRyL25zLmMNCj4gQEAg
LTY5Nyw3ICs2OTcsNyBAQCBpbnQgcXJ0cl9uc19pbml0KHZvaWQpDQo+ICAJaWYgKHJldCA8IDAp
DQo+ICAJCXJldHVybiByZXQ7DQo+ICANCj4gLQlyZXQgPSBrZXJuZWxfZ2V0c29ja25hbWUocXJ0
cl9ucy5zb2NrLCAoc3RydWN0IHNvY2thZGRyICopJnNxKTsNCj4gKwlyZXQgPSBrZXJuZWxfZ2V0
c29ja25hbWUocXJ0cl9ucy5zb2NrLCAoc3RydWN0IHNvY2thZGRyX3N0b3JhZ2UgKikmc3EpOw0K
PiAgCWlmIChyZXQgPCAwKSB7DQo+ICAJCXByX2VycigiZmFpbGVkIHRvIGdldCBzb2NrZXQgbmFt
ZVxuIik7DQo+ICAJCWdvdG8gZXJyX3NvY2s7DQo+IGRpZmYgLS1naXQgYS9uZXQvcmRzL2FmX3Jk
cy5jIGIvbmV0L3Jkcy9hZl9yZHMuYw0KPiBpbmRleCA4NDM1YTIwOTY4ZWYuLjZkMGNlZjAyODQ1
NCAxMDA2NDQNCj4gLS0tIGEvbmV0L3Jkcy9hZl9yZHMuYw0KPiArKysgYi9uZXQvcmRzL2FmX3Jk
cy5jDQo+IEBAIC0xMTEsNyArMTExLDcgQEAgdm9pZCByZHNfd2FrZV9za19zbGVlcChzdHJ1Y3Qg
cmRzX3NvY2sgKnJzKQ0KPiAgCXJlYWRfdW5sb2NrX2lycXJlc3RvcmUoJnJzLT5yc19yZWN2X2xv
Y2ssIGZsYWdzKTsNCj4gIH0NCj4gIA0KPiAtc3RhdGljIGludCByZHNfZ2V0bmFtZShzdHJ1Y3Qg
c29ja2V0ICpzb2NrLCBzdHJ1Y3Qgc29ja2FkZHIgKnVhZGRyLA0KPiArc3RhdGljIGludCByZHNf
Z2V0bmFtZShzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBzdHJ1Y3Qgc29ja2FkZHJfc3RvcmFnZSAqdWFk
ZHIsDQpJIG1pc3NlZCB0aGlzIHNtYWxsIHJkcyBjaGFuZ2UgaGVyZSBlYXJsaWVyLiAgVGhpcyBj
aGFuZ2UgbG9va3MgZmluZSB0byBtZS4gIFRoYW5rcyBLZWVzISAgU29ycnkgZm9yIHRoZSBkZWxh
eSENCkFja2VkLWJ5OiBBbGxpc29uIEhlbmRlcnNvbiA8YWxsaXNvbi5oZW5kZXJzb25Ab3JhY2xl
LmNvbT4NCg0KQWxsaXNvbg0KPiAgCQkgICAgICAgaW50IHBlZXIpDQo+ICB7DQo+ICAJc3RydWN0
IHJkc19zb2NrICpycyA9IHJkc19za190b19ycyhzb2NrLT5zayk7DQo+IGRpZmYgLS1naXQgYS9u
ZXQvcm9zZS9hZl9yb3NlLmMgYi9uZXQvcm9zZS9hZl9yb3NlLmMNCj4gaW5kZXggNTkwNTBjYWFi
NjVjLi4wMjYwYTU4NjJjZjcgMTAwNjQ0DQo+IC0tLSBhL25ldC9yb3NlL2FmX3Jvc2UuYw0KPiAr
KysgYi9uZXQvcm9zZS9hZl9yb3NlLmMNCj4gQEAgLTk4NCw4ICs5ODQsOCBAQCBzdGF0aWMgaW50
IHJvc2VfYWNjZXB0KHN0cnVjdCBzb2NrZXQgKnNvY2ssIHN0cnVjdCBzb2NrZXQgKm5ld3NvY2ss
DQo+ICAJcmV0dXJuIGVycjsNCj4gIH0NCj4gIA0KPiAtc3RhdGljIGludCByb3NlX2dldG5hbWUo
c3RydWN0IHNvY2tldCAqc29jaywgc3RydWN0IHNvY2thZGRyICp1YWRkciwNCj4gLQlpbnQgcGVl
cikNCj4gK3N0YXRpYyBpbnQgcm9zZV9nZXRuYW1lKHN0cnVjdCBzb2NrZXQgKnNvY2ssIHN0cnVj
dCBzb2NrYWRkcl9zdG9yYWdlICp1YWRkciwNCj4gKwkJCWludCBwZWVyKQ0KPiAgew0KPiAgCXN0
cnVjdCBmdWxsX3NvY2thZGRyX3Jvc2UgKnNyb3NlID0gKHN0cnVjdCBmdWxsX3NvY2thZGRyX3Jv
c2UgKil1YWRkcjsNCj4gIAlzdHJ1Y3Qgc29jayAqc2sgPSBzb2NrLT5zazsNCj4gZGlmZiAtLWdp
dCBhL25ldC9zY3RwL2lwdjYuYyBiL25ldC9zY3RwL2lwdjYuYw0KPiBpbmRleCBhOWVkMmNjYWIx
YmQuLjJkOGRlY2FhZTYwOSAxMDA2NDQNCj4gLS0tIGEvbmV0L3NjdHAvaXB2Ni5jDQo+ICsrKyBi
L25ldC9zY3RwL2lwdjYuYw0KPiBAQCAtMTA2NSw3ICsxMDY1LDcgQEAgc3RhdGljIGludCBzY3Rw
X2luZXQ2X3N1cHBvcnRlZF9hZGRycyhjb25zdCBzdHJ1Y3Qgc2N0cF9zb2NrICpvcHQsDQo+ICB9
DQo+ICANCj4gIC8qIEhhbmRsZSBTQ1RQX0lfV0FOVF9NQVBQRURfVjRfQUREUiBmb3IgZ2V0cGVl
cm5hbWUoKSBhbmQgZ2V0c29ja25hbWUoKSAqLw0KPiAtc3RhdGljIGludCBzY3RwX2dldG5hbWUo
c3RydWN0IHNvY2tldCAqc29jaywgc3RydWN0IHNvY2thZGRyICp1YWRkciwNCj4gK3N0YXRpYyBp
bnQgc2N0cF9nZXRuYW1lKHN0cnVjdCBzb2NrZXQgKnNvY2ssIHN0cnVjdCBzb2NrYWRkcl9zdG9y
YWdlICp1YWRkciwNCj4gIAkJCWludCBwZWVyKQ0KPiAgew0KPiAgCWludCByYzsNCj4gZGlmZiAt
LWdpdCBhL25ldC9zbWMvYWZfc21jLmMgYi9uZXQvc21jL2FmX3NtYy5jDQo+IGluZGV4IDllNmM2
OWQxODU4MS4uNWQ0NGQyMzkyMjY4IDEwMDY0NA0KPiAtLS0gYS9uZXQvc21jL2FmX3NtYy5jDQo+
ICsrKyBiL25ldC9zbWMvYWZfc21jLmMNCj4gQEAgLTI3NDEsNyArMjc0MSw3IEBAIGludCBzbWNf
YWNjZXB0KHN0cnVjdCBzb2NrZXQgKnNvY2ssIHN0cnVjdCBzb2NrZXQgKm5ld19zb2NrLA0KPiAg
CXJldHVybiByYzsNCj4gIH0NCj4gIA0KPiAtaW50IHNtY19nZXRuYW1lKHN0cnVjdCBzb2NrZXQg
KnNvY2ssIHN0cnVjdCBzb2NrYWRkciAqYWRkciwNCj4gK2ludCBzbWNfZ2V0bmFtZShzdHJ1Y3Qg
c29ja2V0ICpzb2NrLCBzdHJ1Y3Qgc29ja2FkZHJfc3RvcmFnZSAqYWRkciwNCj4gIAkJaW50IHBl
ZXIpDQo+ICB7DQo+ICAJc3RydWN0IHNtY19zb2NrICpzbWM7DQo+IGRpZmYgLS1naXQgYS9uZXQv
c21jL3NtYy5oIGIvbmV0L3NtYy9zbWMuaA0KPiBpbmRleCA3OGFlMTBkMDZlZDIuLjI0MjYwZjRl
NjgzMCAxMDA2NDQNCj4gLS0tIGEvbmV0L3NtYy9zbWMuaA0KPiArKysgYi9uZXQvc21jL3NtYy5o
DQo+IEBAIC00OCw3ICs0OCw3IEBAIGludCBzbWNfY29ubmVjdChzdHJ1Y3Qgc29ja2V0ICpzb2Nr
LCBzdHJ1Y3Qgc29ja2FkZHIgKmFkZHIsDQo+ICAJCWludCBhbGVuLCBpbnQgZmxhZ3MpOw0KPiAg
aW50IHNtY19hY2NlcHQoc3RydWN0IHNvY2tldCAqc29jaywgc3RydWN0IHNvY2tldCAqbmV3X3Nv
Y2ssDQo+ICAJICAgICAgIHN0cnVjdCBwcm90b19hY2NlcHRfYXJnICphcmcpOw0KPiAtaW50IHNt
Y19nZXRuYW1lKHN0cnVjdCBzb2NrZXQgKnNvY2ssIHN0cnVjdCBzb2NrYWRkciAqYWRkciwNCj4g
K2ludCBzbWNfZ2V0bmFtZShzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBzdHJ1Y3Qgc29ja2FkZHJfc3Rv
cmFnZSAqYWRkciwNCj4gIAkJaW50IHBlZXIpOw0KPiAgX19wb2xsX3Qgc21jX3BvbGwoc3RydWN0
IGZpbGUgKmZpbGUsIHN0cnVjdCBzb2NrZXQgKnNvY2ssDQo+ICAJCSAgcG9sbF90YWJsZSAqd2Fp
dCk7DQo+IGRpZmYgLS1naXQgYS9uZXQvc21jL3NtY19jbGMuYyBiL25ldC9zbWMvc21jX2NsYy5j
DQo+IGluZGV4IDMzZmE3ODdjMjhlYi4uNmVlYjVkZWNjNTFlIDEwMDY0NA0KPiAtLS0gYS9uZXQv
c21jL3NtY19jbGMuYw0KPiArKysgYi9uZXQvc21jL3NtY19jbGMuYw0KPiBAQCAtNTcxLDcgKzU3
MSw3IEBAIHN0YXRpYyBpbnQgc21jX2NsY19wcmZ4X3NldChzdHJ1Y3Qgc29ja2V0ICpjbGNzb2Nr
LA0KPiAgCQlnb3RvIG91dF9yZWw7DQo+ICAJfQ0KPiAgCS8qIGdldCBhZGRyZXNzIHRvIHdoaWNo
IHRoZSBpbnRlcm5hbCBUQ1Agc29ja2V0IGlzIGJvdW5kICovDQo+IC0JaWYgKGtlcm5lbF9nZXRz
b2NrbmFtZShjbGNzb2NrLCAoc3RydWN0IHNvY2thZGRyICopJmFkZHJzKSA8IDApDQo+ICsJaWYg
KGtlcm5lbF9nZXRzb2NrbmFtZShjbGNzb2NrLCAmYWRkcnMpIDwgMCkNCj4gIAkJZ290byBvdXRf
cmVsOw0KPiAgCS8qIGFuYWx5emUgSVAgc3BlY2lmaWMgZGF0YSBvZiBuZXRfZGV2aWNlIGJlbG9u
Z2luZyB0byBUQ1Agc29ja2V0ICovDQo+ICAJYWRkcjYgPSAoc3RydWN0IHNvY2thZGRyX2luNiAq
KSZhZGRyczsNCj4gZGlmZiAtLWdpdCBhL25ldC9zb2NrZXQuYyBiL25ldC9zb2NrZXQuYw0KPiBp
bmRleCA5YTExNzI0OGYxOGYuLmIxMGYyYjNmNDA1NCAxMDA2NDQNCj4gLS0tIGEvbmV0L3NvY2tl
dC5jDQo+ICsrKyBiL25ldC9zb2NrZXQuYw0KPiBAQCAtMTk0Myw3ICsxOTQzLDcgQEAgc3RydWN0
IGZpbGUgKmRvX2FjY2VwdChzdHJ1Y3QgZmlsZSAqZmlsZSwgc3RydWN0IHByb3RvX2FjY2VwdF9h
cmcgKmFyZywNCj4gIAkJZ290byBvdXRfZmQ7DQo+ICANCj4gIAlpZiAodXBlZXJfc29ja2FkZHIp
IHsNCj4gLQkJbGVuID0gb3BzLT5nZXRuYW1lKG5ld3NvY2ssIChzdHJ1Y3Qgc29ja2FkZHIgKikm
YWRkcmVzcywgMik7DQo+ICsJCWxlbiA9IG9wcy0+Z2V0bmFtZShuZXdzb2NrLCAmYWRkcmVzcywg
Mik7DQo+ICAJCWlmIChsZW4gPCAwKSB7DQo+ICAJCQllcnIgPSAtRUNPTk5BQk9SVEVEOw0KPiAg
CQkJZ290byBvdXRfZmQ7DQo+IEBAIC0yMTAzLDcgKzIxMDMsNyBAQCBpbnQgX19zeXNfZ2V0c29j
a25hbWUoaW50IGZkLCBzdHJ1Y3Qgc29ja2FkZHIgX191c2VyICp1c29ja2FkZHIsDQo+ICAJaWYg
KGVycikNCj4gIAkJcmV0dXJuIGVycjsNCj4gIA0KPiAtCWVyciA9IFJFQURfT05DRShzb2NrLT5v
cHMpLT5nZXRuYW1lKHNvY2ssIChzdHJ1Y3Qgc29ja2FkZHIgKikmYWRkcmVzcywgMCk7DQo+ICsJ
ZXJyID0gUkVBRF9PTkNFKHNvY2stPm9wcyktPmdldG5hbWUoc29jaywgJmFkZHJlc3MsIDApOw0K
PiAgCWlmIChlcnIgPCAwKQ0KPiAgCQlyZXR1cm4gZXJyOw0KPiAgDQo+IEBAIC0yMTQwLDcgKzIx
NDAsNyBAQCBpbnQgX19zeXNfZ2V0cGVlcm5hbWUoaW50IGZkLCBzdHJ1Y3Qgc29ja2FkZHIgX191
c2VyICp1c29ja2FkZHIsDQo+ICAJaWYgKGVycikNCj4gIAkJcmV0dXJuIGVycjsNCj4gIA0KPiAt
CWVyciA9IFJFQURfT05DRShzb2NrLT5vcHMpLT5nZXRuYW1lKHNvY2ssIChzdHJ1Y3Qgc29ja2Fk
ZHIgKikmYWRkcmVzcywgMSk7DQo+ICsJZXJyID0gUkVBRF9PTkNFKHNvY2stPm9wcyktPmdldG5h
bWUoc29jaywgJmFkZHJlc3MsIDEpOw0KPiAgCWlmIChlcnIgPCAwKQ0KPiAgCQlyZXR1cm4gZXJy
Ow0KPiAgDQo+IEBAIC0zNjM2LDcgKzM2MzYsNyBAQCBFWFBPUlRfU1lNQk9MKGtlcm5lbF9jb25u
ZWN0KTsNCj4gICAqCVJldHVybnMgdGhlIGxlbmd0aCBvZiB0aGUgYWRkcmVzcyBpbiBieXRlcyBv
ciBhbiBlcnJvciBjb2RlLg0KPiAgICovDQo+ICANCj4gLWludCBrZXJuZWxfZ2V0c29ja25hbWUo
c3RydWN0IHNvY2tldCAqc29jaywgc3RydWN0IHNvY2thZGRyICphZGRyKQ0KPiAraW50IGtlcm5l
bF9nZXRzb2NrbmFtZShzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBzdHJ1Y3Qgc29ja2FkZHJfc3RvcmFn
ZSAqYWRkcikNCj4gIHsNCj4gIAlyZXR1cm4gUkVBRF9PTkNFKHNvY2stPm9wcyktPmdldG5hbWUo
c29jaywgYWRkciwgMCk7DQo+ICB9DQo+IEBAIC0zNjUxLDcgKzM2NTEsNyBAQCBFWFBPUlRfU1lN
Qk9MKGtlcm5lbF9nZXRzb2NrbmFtZSk7DQo+ICAgKglSZXR1cm5zIHRoZSBsZW5ndGggb2YgdGhl
IGFkZHJlc3MgaW4gYnl0ZXMgb3IgYW4gZXJyb3IgY29kZS4NCj4gICAqLw0KPiAgDQo+IC1pbnQg
a2VybmVsX2dldHBlZXJuYW1lKHN0cnVjdCBzb2NrZXQgKnNvY2ssIHN0cnVjdCBzb2NrYWRkciAq
YWRkcikNCj4gK2ludCBrZXJuZWxfZ2V0cGVlcm5hbWUoc3RydWN0IHNvY2tldCAqc29jaywgc3Ry
dWN0IHNvY2thZGRyX3N0b3JhZ2UgKmFkZHIpDQo+ICB7DQo+ICAJcmV0dXJuIFJFQURfT05DRShz
b2NrLT5vcHMpLT5nZXRuYW1lKHNvY2ssIGFkZHIsIDEpOw0KPiAgfQ0KPiBkaWZmIC0tZ2l0IGEv
bmV0L3N1bnJwYy9jbG50LmMgYi9uZXQvc3VucnBjL2NsbnQuYw0KPiBpbmRleCAwMDkwMTYyZWU4
YzMuLjhhZjI1M2Y1YWQwOCAxMDA2NDQNCj4gLS0tIGEvbmV0L3N1bnJwYy9jbG50LmMNCj4gKysr
IGIvbmV0L3N1bnJwYy9jbG50LmMNCj4gQEAgLTE0NDUsNyArMTQ0NSw3IEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3Qgc29ja2FkZHJfaW42IHJwY19pbjZhZGRyX2xvb3BiYWNrID0gew0KPiAgICogbmVn
YXRpdmUgZXJybm8gaXMgcmV0dXJuZWQuDQo+ICAgKi8NCj4gIHN0YXRpYyBpbnQgcnBjX3NvY2tu
YW1lKHN0cnVjdCBuZXQgKm5ldCwgc3RydWN0IHNvY2thZGRyICpzYXAsIHNpemVfdCBzYWxlbiwN
Cj4gLQkJCXN0cnVjdCBzb2NrYWRkciAqYnVmKQ0KPiArCQkJc3RydWN0IHNvY2thZGRyX3N0b3Jh
Z2UgKmJ1ZikNCj4gIHsNCj4gIAlzdHJ1Y3Qgc29ja2V0ICpzb2NrOw0KPiAgCWludCBlcnI7DQo+
IEBAIC0xNDkwLDcgKzE0OTAsNyBAQCBzdGF0aWMgaW50IHJwY19zb2NrbmFtZShzdHJ1Y3QgbmV0
ICpuZXQsIHN0cnVjdCBzb2NrYWRkciAqc2FwLCBzaXplX3Qgc2FsZW4sDQo+ICAJfQ0KPiAgDQo+
ICAJZXJyID0gMDsNCj4gLQlpZiAoYnVmLT5zYV9mYW1pbHkgPT0gQUZfSU5FVDYpIHsNCj4gKwlp
ZiAoYnVmLT5zc19mYW1pbHkgPT0gQUZfSU5FVDYpIHsNCj4gIAkJc3RydWN0IHNvY2thZGRyX2lu
NiAqc2luNiA9IChzdHJ1Y3Qgc29ja2FkZHJfaW42ICopYnVmOw0KPiAgCQlzaW42LT5zaW42X3Nj
b3BlX2lkID0gMDsNCj4gIAl9DQo+IEBAIC0xNTEwLDcgKzE1MTAsNyBAQCBzdGF0aWMgaW50IHJw
Y19zb2NrbmFtZShzdHJ1Y3QgbmV0ICpuZXQsIHN0cnVjdCBzb2NrYWRkciAqc2FwLCBzaXplX3Qg
c2FsZW4sDQo+ICAgKiBSZXR1cm5zIHplcm8gYW5kIGZpbGxzIGluICJidWYiIGlmIHN1Y2Nlc3Nm
dWw7IG90aGVyd2lzZSwgYQ0KPiAgICogbmVnYXRpdmUgZXJybm8gaXMgcmV0dXJuZWQuDQo+ICAg
Ki8NCj4gLXN0YXRpYyBpbnQgcnBjX2FueWFkZHIoaW50IGZhbWlseSwgc3RydWN0IHNvY2thZGRy
ICpidWYsIHNpemVfdCBidWZsZW4pDQo+ICtzdGF0aWMgaW50IHJwY19hbnlhZGRyKGludCBmYW1p
bHksIHN0cnVjdCBzb2NrYWRkcl9zdG9yYWdlICpidWYsIHNpemVfdCBidWZsZW4pDQo+ICB7DQo+
ICAJc3dpdGNoIChmYW1pbHkpIHsNCj4gIAljYXNlIEFGX0lORVQ6DQo+IEBAIC0xNTUwLDcgKzE1
NTAsOCBAQCBzdGF0aWMgaW50IHJwY19hbnlhZGRyKGludCBmYW1pbHksIHN0cnVjdCBzb2NrYWRk
ciAqYnVmLCBzaXplX3QgYnVmbGVuKQ0KPiAgICogc3VjY2Vzc2lvbiBtYXkgZ2l2ZSBkaWZmZXJl
bnQgcmVzdWx0cywgZGVwZW5kaW5nIG9uIGhvdyBsb2NhbA0KPiAgICogbmV0d29ya2luZyBjb25m
aWd1cmF0aW9uIGNoYW5nZXMgb3ZlciB0aW1lLg0KPiAgICovDQo+IC1pbnQgcnBjX2xvY2FsYWRk
cihzdHJ1Y3QgcnBjX2NsbnQgKmNsbnQsIHN0cnVjdCBzb2NrYWRkciAqYnVmLCBzaXplX3QgYnVm
bGVuKQ0KPiAraW50IHJwY19sb2NhbGFkZHIoc3RydWN0IHJwY19jbG50ICpjbG50LCBzdHJ1Y3Qg
c29ja2FkZHJfc3RvcmFnZSAqYnVmLA0KPiArCQkgIHNpemVfdCBidWZsZW4pDQo+ICB7DQo+ICAJ
c3RydWN0IHNvY2thZGRyX3N0b3JhZ2UgYWRkcmVzczsNCj4gIAlzdHJ1Y3Qgc29ja2FkZHIgKnNh
cCA9IChzdHJ1Y3Qgc29ja2FkZHIgKikmYWRkcmVzczsNCj4gZGlmZiAtLWdpdCBhL25ldC9zdW5y
cGMvc3Zjc29jay5jIGIvbmV0L3N1bnJwYy9zdmNzb2NrLmMNCj4gaW5kZXggOTUzOTc2Nzc2NzNi
Li5iMDYyZmFkYjJlNmIgMTAwNjQ0DQo+IC0tLSBhL25ldC9zdW5ycGMvc3Zjc29jay5jDQo+ICsr
KyBiL25ldC9zdW5ycGMvc3Zjc29jay5jDQo+IEBAIC05MDMsNyArOTAzLDcgQEAgc3RhdGljIHN0
cnVjdCBzdmNfeHBydCAqc3ZjX3RjcF9hY2NlcHQoc3RydWN0IHN2Y194cHJ0ICp4cHJ0KQ0KPiAg
DQo+ICAJc2V0X2JpdChYUFRfQ09OTiwgJnN2c2stPnNrX3hwcnQueHB0X2ZsYWdzKTsNCj4gIA0K
PiAtCWVyciA9IGtlcm5lbF9nZXRwZWVybmFtZShuZXdzb2NrLCBzaW4pOw0KPiArCWVyciA9IGtl
cm5lbF9nZXRwZWVybmFtZShuZXdzb2NrLCAmYWRkcik7DQo+ICAJaWYgKGVyciA8IDApIHsNCj4g
IAkJdHJhY2Vfc3Zjc29ja19nZXRwZWVybmFtZV9lcnIoeHBydCwgc2Vydi0+c3ZfbmFtZSwgZXJy
KTsNCj4gIAkJZ290byBmYWlsZWQ7CQkvKiBhYm9ydGVkIGNvbm5lY3Rpb24gb3Igd2hhdGV2ZXIg
Ki8NCj4gQEAgLTkyNSw3ICs5MjUsNyBAQCBzdGF0aWMgc3RydWN0IHN2Y194cHJ0ICpzdmNfdGNw
X2FjY2VwdChzdHJ1Y3Qgc3ZjX3hwcnQgKnhwcnQpDQo+ICAJaWYgKElTX0VSUihuZXdzdnNrKSkN
Cj4gIAkJZ290byBmYWlsZWQ7DQo+ICAJc3ZjX3hwcnRfc2V0X3JlbW90ZSgmbmV3c3Zzay0+c2tf
eHBydCwgc2luLCBzbGVuKTsNCj4gLQllcnIgPSBrZXJuZWxfZ2V0c29ja25hbWUobmV3c29jaywg
c2luKTsNCj4gKwllcnIgPSBrZXJuZWxfZ2V0c29ja25hbWUobmV3c29jaywgJmFkZHIpOw0KPiAg
CXNsZW4gPSBlcnI7DQo+ICAJaWYgKHVubGlrZWx5KGVyciA8IDApKQ0KPiAgCQlzbGVuID0gb2Zm
c2V0b2Yoc3RydWN0IHNvY2thZGRyLCBzYV9kYXRhKTsNCj4gQEAgLTE0NzgsNyArMTQ3OCw3IEBA
IGludCBzdmNfYWRkc29jayhzdHJ1Y3Qgc3ZjX3NlcnYgKnNlcnYsIHN0cnVjdCBuZXQgKm5ldCwg
Y29uc3QgaW50IGZkLA0KPiAgCQllcnIgPSBQVFJfRVJSKHN2c2spOw0KPiAgCQlnb3RvIG91dDsN
Cj4gIAl9DQo+IC0Jc2FsZW4gPSBrZXJuZWxfZ2V0c29ja25hbWUoc3Zzay0+c2tfc29jaywgc2lu
KTsNCj4gKwlzYWxlbiA9IGtlcm5lbF9nZXRzb2NrbmFtZShzdnNrLT5za19zb2NrLCAmYWRkcik7
DQo+ICAJaWYgKHNhbGVuID49IDApDQo+ICAJCXN2Y194cHJ0X3NldF9sb2NhbCgmc3Zzay0+c2tf
eHBydCwgc2luLCBzYWxlbik7DQo+ICAJc3Zzay0+c2tfeHBydC54cHRfY3JlZCA9IGdldF9jcmVk
KGNyZWQpOw0KPiBAQCAtMTU0NSw3ICsxNTQ1LDcgQEAgc3RhdGljIHN0cnVjdCBzdmNfeHBydCAq
c3ZjX2NyZWF0ZV9zb2NrZXQoc3RydWN0IHN2Y19zZXJ2ICpzZXJ2LA0KPiAgCWlmIChlcnJvciA8
IDApDQo+ICAJCWdvdG8gYnVtbWVyOw0KPiAgDQo+IC0JZXJyb3IgPSBrZXJuZWxfZ2V0c29ja25h
bWUoc29jaywgbmV3c2luKTsNCj4gKwllcnJvciA9IGtlcm5lbF9nZXRzb2NrbmFtZShzb2NrLCAm
YWRkcik7DQo+ICAJaWYgKGVycm9yIDwgMCkNCj4gIAkJZ290byBidW1tZXI7DQo+ICAJbmV3bGVu
ID0gZXJyb3I7DQo+IGRpZmYgLS1naXQgYS9uZXQvc3VucnBjL3hwcnRzb2NrLmMgYi9uZXQvc3Vu
cnBjL3hwcnRzb2NrLmMNCj4gaW5kZXggYzYwOTM2ZDhjZWY3Li43MzVjM2MxZDJiZGYgMTAwNjQ0
DQo+IC0tLSBhL25ldC9zdW5ycGMveHBydHNvY2suYw0KPiArKysgYi9uZXQvc3VucnBjL3hwcnRz
b2NrLmMNCj4gQEAgLTE3MTAsNyArMTcxMCw3IEBAIHN0YXRpYyB1bnNpZ25lZCBzaG9ydCB4c19z
b2NrX2dldHBvcnQoc3RydWN0IHNvY2tldCAqc29jaykNCj4gIAlzdHJ1Y3Qgc29ja2FkZHJfc3Rv
cmFnZSBidWY7DQo+ICAJdW5zaWduZWQgc2hvcnQgcG9ydCA9IDA7DQo+ICANCj4gLQlpZiAoa2Vy
bmVsX2dldHNvY2tuYW1lKHNvY2ssIChzdHJ1Y3Qgc29ja2FkZHIgKikmYnVmKSA8IDApDQo+ICsJ
aWYgKGtlcm5lbF9nZXRzb2NrbmFtZShzb2NrLCAmYnVmKSA8IDApDQo+ICAJCWdvdG8gb3V0Ow0K
PiAgCXN3aXRjaCAoYnVmLnNzX2ZhbWlseSkgew0KPiAgCWNhc2UgQUZfSU5FVDY6DQo+IEBAIC0x
Nzc5LDcgKzE3NzksNyBAQCBzdGF0aWMgaW50IHhzX3NvY2tfc3JjYWRkcihzdHJ1Y3QgcnBjX3hw
cnQgKnhwcnQsIGNoYXIgKmJ1Ziwgc2l6ZV90IGJ1ZmxlbikNCj4gIA0KPiAgCW11dGV4X2xvY2so
JnNvY2stPnJlY3ZfbXV0ZXgpOw0KPiAgCWlmIChzb2NrLT5zb2NrKSB7DQo+IC0JCXJldCA9IGtl
cm5lbF9nZXRzb2NrbmFtZShzb2NrLT5zb2NrLCAmc2FkZHIuc2EpOw0KPiArCQlyZXQgPSBrZXJu
ZWxfZ2V0c29ja25hbWUoc29jay0+c29jaywgJnNhZGRyLnN0KTsNCj4gIAkJaWYgKHJldCA+PSAw
KQ0KPiAgCQkJcmV0ID0gc25wcmludGYoYnVmLCBidWZsZW4sICIlcElTYyIsICZzYWRkci5zYSk7
DQo+ICAJfQ0KPiBkaWZmIC0tZ2l0IGEvbmV0L3RpcGMvc29ja2V0LmMgYi9uZXQvdGlwYy9zb2Nr
ZXQuYw0KPiBpbmRleCA2NWRjYmI1NGY1NWQuLjU2ZjYwOWM3ZjJhNiAxMDA2NDQNCj4gLS0tIGEv
bmV0L3RpcGMvc29ja2V0LmMNCj4gKysrIGIvbmV0L3RpcGMvc29ja2V0LmMNCj4gQEAgLTc0MSw3
ICs3NDEsNyBAQCBzdGF0aWMgaW50IHRpcGNfYmluZChzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBzdHJ1
Y3Qgc29ja2FkZHIgKnNrYWRkciwgaW50IGFsZW4pDQo+ICAgKiAgICAgICBhY2Nlc3NlcyBzb2Nr
ZXQgaW5mb3JtYXRpb24gdGhhdCBpcyB1bmNoYW5naW5nIChvciB3aGljaCBjaGFuZ2VzIGluDQo+
ICAgKiAgICAgICBhIGNvbXBsZXRlbHkgcHJlZGljdGFibGUgbWFubmVyKS4NCj4gICAqLw0KPiAt
c3RhdGljIGludCB0aXBjX2dldG5hbWUoc3RydWN0IHNvY2tldCAqc29jaywgc3RydWN0IHNvY2th
ZGRyICp1YWRkciwNCj4gK3N0YXRpYyBpbnQgdGlwY19nZXRuYW1lKHN0cnVjdCBzb2NrZXQgKnNv
Y2ssIHN0cnVjdCBzb2NrYWRkcl9zdG9yYWdlICp1YWRkciwNCj4gIAkJCWludCBwZWVyKQ0KPiAg
ew0KPiAgCXN0cnVjdCBzb2NrYWRkcl90aXBjICphZGRyID0gKHN0cnVjdCBzb2NrYWRkcl90aXBj
ICopdWFkZHI7DQo+IGRpZmYgLS1naXQgYS9uZXQvdW5peC9hZl91bml4LmMgYi9uZXQvdW5peC9h
Zl91bml4LmMNCj4gaW5kZXggMDAxY2NjNTVlZjBmLi4wZjcxZWQyZjM1ZTcgMTAwNjQ0DQo+IC0t
LSBhL25ldC91bml4L2FmX3VuaXguYw0KPiArKysgYi9uZXQvdW5peC9hZl91bml4LmMNCj4gQEAg
LTgxMyw3ICs4MTMsNyBAQCBzdGF0aWMgaW50IHVuaXhfc3RyZWFtX2Nvbm5lY3Qoc3RydWN0IHNv
Y2tldCAqLCBzdHJ1Y3Qgc29ja2FkZHIgKiwNCj4gIAkJCSAgICAgICBpbnQgYWRkcl9sZW4sIGlu
dCBmbGFncyk7DQo+ICBzdGF0aWMgaW50IHVuaXhfc29ja2V0cGFpcihzdHJ1Y3Qgc29ja2V0ICos
IHN0cnVjdCBzb2NrZXQgKik7DQo+ICBzdGF0aWMgaW50IHVuaXhfYWNjZXB0KHN0cnVjdCBzb2Nr
ZXQgKiwgc3RydWN0IHNvY2tldCAqLCBzdHJ1Y3QgcHJvdG9fYWNjZXB0X2FyZyAqYXJnKTsNCj4g
LXN0YXRpYyBpbnQgdW5peF9nZXRuYW1lKHN0cnVjdCBzb2NrZXQgKiwgc3RydWN0IHNvY2thZGRy
ICosIGludCk7DQo+ICtzdGF0aWMgaW50IHVuaXhfZ2V0bmFtZShzdHJ1Y3Qgc29ja2V0ICosIHN0
cnVjdCBzb2NrYWRkcl9zdG9yYWdlICosIGludCk7DQo+ICBzdGF0aWMgX19wb2xsX3QgdW5peF9w
b2xsKHN0cnVjdCBmaWxlICosIHN0cnVjdCBzb2NrZXQgKiwgcG9sbF90YWJsZSAqKTsNCj4gIHN0
YXRpYyBfX3BvbGxfdCB1bml4X2RncmFtX3BvbGwoc3RydWN0IGZpbGUgKiwgc3RydWN0IHNvY2tl
dCAqLA0KPiAgCQkJCSAgICBwb2xsX3RhYmxlICopOw0KPiBAQCAtMTc4OSw3ICsxNzg5LDggQEAg
c3RhdGljIGludCB1bml4X2FjY2VwdChzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBzdHJ1Y3Qgc29ja2V0
ICpuZXdzb2NrLA0KPiAgfQ0KPiAgDQo+ICANCj4gLXN0YXRpYyBpbnQgdW5peF9nZXRuYW1lKHN0
cnVjdCBzb2NrZXQgKnNvY2ssIHN0cnVjdCBzb2NrYWRkciAqdWFkZHIsIGludCBwZWVyKQ0KPiAr
c3RhdGljIGludCB1bml4X2dldG5hbWUoc3RydWN0IHNvY2tldCAqc29jaywgc3RydWN0IHNvY2th
ZGRyX3N0b3JhZ2UgKnVhZGRyLA0KPiArCQkJaW50IHBlZXIpDQo+ICB7DQo+ICAJc3RydWN0IHNv
Y2sgKnNrID0gc29jay0+c2s7DQo+ICAJc3RydWN0IHVuaXhfYWRkcmVzcyAqYWRkcjsNCj4gQEAg
LTE4MTcsMTAgKzE4MTgsMTAgQEAgc3RhdGljIGludCB1bml4X2dldG5hbWUoc3RydWN0IHNvY2tl
dCAqc29jaywgc3RydWN0IHNvY2thZGRyICp1YWRkciwgaW50IHBlZXIpDQo+ICAJCW1lbWNweShz
dW5hZGRyLCBhZGRyLT5uYW1lLCBhZGRyLT5sZW4pOw0KPiAgDQo+ICAJCWlmIChwZWVyKQ0KPiAt
CQkJQlBGX0NHUk9VUF9SVU5fU0FfUFJPRyhzaywgdWFkZHIsICZlcnIsDQo+ICsJCQlCUEZfQ0dS
T1VQX1JVTl9TQV9QUk9HKHNrLCAoc3RydWN0IHNvY2thZGRyICopdWFkZHIsICZlcnIsDQo+ICAJ
CQkJCSAgICAgICBDR1JPVVBfVU5JWF9HRVRQRUVSTkFNRSk7DQo+ICAJCWVsc2UNCj4gLQkJCUJQ
Rl9DR1JPVVBfUlVOX1NBX1BST0coc2ssIHVhZGRyLCAmZXJyLA0KPiArCQkJQlBGX0NHUk9VUF9S
VU5fU0FfUFJPRyhzaywgKHN0cnVjdCBzb2NrYWRkciAqKXVhZGRyLCAmZXJyLA0KPiAgCQkJCQkg
ICAgICAgQ0dST1VQX1VOSVhfR0VUU09DS05BTUUpOw0KPiAgCX0NCj4gIAlzb2NrX3B1dChzayk7
DQo+IGRpZmYgLS1naXQgYS9uZXQvdm13X3Zzb2NrL2FmX3Zzb2NrLmMgYi9uZXQvdm13X3Zzb2Nr
L2FmX3Zzb2NrLmMNCj4gaW5kZXggNWNmODEwOWY2NzJhLi42YjUxZWU5Y2I4ZDMgMTAwNjQ0DQo+
IC0tLSBhL25ldC92bXdfdnNvY2svYWZfdnNvY2suYw0KPiArKysgYi9uZXQvdm13X3Zzb2NrL2Fm
X3Zzb2NrLmMNCj4gQEAgLTk0Myw3ICs5NDMsNyBAQCB2c29ja19iaW5kKHN0cnVjdCBzb2NrZXQg
KnNvY2ssIHN0cnVjdCBzb2NrYWRkciAqYWRkciwgaW50IGFkZHJfbGVuKQ0KPiAgfQ0KPiAgDQo+
ICBzdGF0aWMgaW50IHZzb2NrX2dldG5hbWUoc3RydWN0IHNvY2tldCAqc29jaywNCj4gLQkJCSBz
dHJ1Y3Qgc29ja2FkZHIgKmFkZHIsIGludCBwZWVyKQ0KPiArCQkJIHN0cnVjdCBzb2NrYWRkcl9z
dG9yYWdlICphZGRyLCBpbnQgcGVlcikNCj4gIHsNCj4gIAlpbnQgZXJyOw0KPiAgCXN0cnVjdCBz
b2NrICpzazsNCj4gZGlmZiAtLWdpdCBhL25ldC94MjUvYWZfeDI1LmMgYi9uZXQveDI1L2FmX3gy
NS5jDQo+IGluZGV4IDhkZGE0MTc4NDk3Yy4uZjk3ODc2ZDMwOTM1IDEwMDY0NA0KPiAtLS0gYS9u
ZXQveDI1L2FmX3gyNS5jDQo+ICsrKyBiL25ldC94MjUvYWZfeDI1LmMNCj4gQEAgLTkxMyw3ICs5
MTMsNyBAQCBzdGF0aWMgaW50IHgyNV9hY2NlcHQoc3RydWN0IHNvY2tldCAqc29jaywgc3RydWN0
IHNvY2tldCAqbmV3c29jaywNCj4gIAlyZXR1cm4gcmM7DQo+ICB9DQo+ICANCj4gLXN0YXRpYyBp
bnQgeDI1X2dldG5hbWUoc3RydWN0IHNvY2tldCAqc29jaywgc3RydWN0IHNvY2thZGRyICp1YWRk
ciwNCj4gK3N0YXRpYyBpbnQgeDI1X2dldG5hbWUoc3RydWN0IHNvY2tldCAqc29jaywgc3RydWN0
IHNvY2thZGRyX3N0b3JhZ2UgKnVhZGRyLA0KPiAgCQkgICAgICAgaW50IHBlZXIpDQo+ICB7DQo+
ICAJc3RydWN0IHNvY2thZGRyX3gyNSAqc3gyNSA9IChzdHJ1Y3Qgc29ja2FkZHJfeDI1ICopdWFk
ZHI7DQo+IGRpZmYgLS1naXQgYS9zZWN1cml0eS90b21veW8vbmV0d29yay5jIGIvc2VjdXJpdHkv
dG9tb3lvL25ldHdvcmsuYw0KPiBpbmRleCA4ZGM2MTMzNWY2NWUuLjQ1MGZkN2EzN2NhNCAxMDA2
NDQNCj4gLS0tIGEvc2VjdXJpdHkvdG9tb3lvL25ldHdvcmsuYw0KPiArKysgYi9zZWN1cml0eS90
b21veW8vbmV0d29yay5jDQo+IEBAIC02NTgsOCArNjU4LDcgQEAgaW50IHRvbW95b19zb2NrZXRf
bGlzdGVuX3Blcm1pc3Npb24oc3RydWN0IHNvY2tldCAqc29jaykNCj4gIAlpZiAoIWZhbWlseSB8
fCAodHlwZSAhPSBTT0NLX1NUUkVBTSAmJiB0eXBlICE9IFNPQ0tfU0VRUEFDS0VUKSkNCj4gIAkJ
cmV0dXJuIDA7DQo+ICAJew0KPiAtCQljb25zdCBpbnQgZXJyb3IgPSBzb2NrLT5vcHMtPmdldG5h
bWUoc29jaywgKHN0cnVjdCBzb2NrYWRkciAqKQ0KPiAtCQkJCQkJICAgICAmYWRkciwgMCk7DQo+
ICsJCWNvbnN0IGludCBlcnJvciA9IHNvY2stPm9wcy0+Z2V0bmFtZShzb2NrLCAmYWRkciwgMCk7
DQo+ICANCj4gIAkJaWYgKGVycm9yIDwgMCkNCj4gIAkJCXJldHVybiBlcnJvcjsNCg0K

