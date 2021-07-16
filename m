Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599643CB326
	for <lists+linux-sctp@lfdr.de>; Fri, 16 Jul 2021 09:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbhGPHTJ (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 16 Jul 2021 03:19:09 -0400
Received: from mail-eopbgr60108.outbound.protection.outlook.com ([40.107.6.108]:43582
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235173AbhGPHTG (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Fri, 16 Jul 2021 03:19:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gA9aWgUCux07EyqFUqTO9Sz9N3+OyLbdI1xOf8X/AnR8PalUueiHSOqjrBA/FSFsRtp439rfcb35We7fiJBhjKj5KFqH6mtP825IGEK34GvVF5YYLhZturPeVtZ2qabF9JkViPjex9Jery+ezsbmFYnpBswmz6ftJnwJT29Z1wrcOv5VQ9H1seG+gj1So1qMNWfsDiSQZVvcoN5Cezx6I3txhP58MlXkf0chqYf7TXYDyqfU1OzwkqcH1PLcUriv9CZKpzBMRoAt9CYszD8RsPR4Y3/7NjNo5bfvvIzMtiLEkkGt/C2u1/8kUpYW3Bfo/4DlhrtiX6f8sQPQg2Q6CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Pk+X+B17dTDkfbeENMJ11XVgpSGgSqlGj2fygzZZ7c=;
 b=kpzoI536h5o/KS+qJK8KMhRGekZsLZ1IJicl+iuz10x69R4XBWjdUS3vcAQiSjTvwPZ7J92bZ66Dp2bJ1vRxa6PyiZoxFRRPme0ZfiG5VklZp7VN3TAqPsOL51Yk+GGvXwhkUCYgY0O8Xl30/IwJhBQ8XscO0oLk/+0c0dHrxg7Q9yodrcC1ahSuhqBjU16hbPy4IDK2U/HaIWMdFlPNLuIRzwMw9TlFwy/RAUuautB0ZT5CCNl40nnjIEei3YUfq7KnOJX3+3tvYT7/r4YnzGQ4Fhszqu1UQ+Uy0+yk10TxviK/glNTdoi+5zoqxQveGf7eUQfxVzECld9lwLHtGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nokia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Pk+X+B17dTDkfbeENMJ11XVgpSGgSqlGj2fygzZZ7c=;
 b=Lgq1+dtsgErs2ZPDmsJGaU6ni+3FQWqbkVKxFtfrt3X+hqMOdHm8WBpl5YeOIUKitgGBm3WzcDHb6MtiBkpfUZpZEuY8AoaKchfPFl1/Xe/In5UxfSlZRsullCA/bbNP0HDnqmG5A043IQUA6dJ+9JBlPqzcrAglQsdjj2b+W3g=
Received: from FR0P281CA0041.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:48::6) by
 AM0PR07MB6084.eurprd07.prod.outlook.com (2603:10a6:208:11b::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.10; Fri, 16 Jul
 2021 07:16:10 +0000
Received: from VE1EUR03FT014.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:d10:48:cafe::71) by FR0P281CA0041.outlook.office365.com
 (2603:10a6:d10:48::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.8 via Frontend
 Transport; Fri, 16 Jul 2021 07:16:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.17)
 smtp.mailfrom=nokia.com; davemloft.net; dkim=none (message not signed)
 header.d=none;davemloft.net; dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.17; helo=fihe3nok0735.emea.nsn-net.net;
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.17) by
 VE1EUR03FT014.mail.protection.outlook.com (10.152.19.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 07:16:09 +0000
Received: from wrlinb133.emea.nsn-net.net (wrlinb133.emea.nsn-net.net [10.159.92.203])
        by fihe3nok0735.emea.nsn-net.net (GMO) with ESMTP id 16G7G4Vf005023;
        Fri, 16 Jul 2021 07:16:07 GMT
From:   Jacek Szafraniec <jacek.szafraniec@nokia.com>
To:     linux-sctp@vger.kernel.org
Cc:     Jacek Szafraniec <jacek.szafraniec@nokia.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Maciej Kwiecien <maciej.kwiecien@nokia.com>
Subject: [PATCH 1/1] sctp: do not update t->pathmtu when PMTUD is disabled
Date:   Fri, 16 Jul 2021 09:16:00 +0200
Message-Id: <20210716071600.53150-2-jacek.szafraniec@nokia.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20210716071600.53150-1-jacek.szafraniec@nokia.com>
References: <20210716071600.53150-1-jacek.szafraniec@nokia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f8d04486-363b-4979-244d-08d94829961c
X-MS-TrafficTypeDiagnostic: AM0PR07MB6084:
X-Microsoft-Antispam-PRVS: <AM0PR07MB6084B75F8AB8FA602B58C46D83119@AM0PR07MB6084.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BszBuwiXqvACmO53slyWzYOHbKLcgBIsVycdWwtX1rV83GvUlXPQu4gCAggeUMfQcU0+rHEuUUpHBFneBuu1PIZiQqF++0nyfg65pbb9pdy7WnH8B/EIiIm9QF+R8vZvlpU1TITqIDABK34AiDGtzC4wc47JPnm8UV55/vn1ezvSZBZHWfI0Jc6M7/mRiYxiWKcRIP5JGZc48jNtcBIuJKvrzMI6qUY0cE7zU0YJ0U8JJI0P9LjMP4s85d7ej89TOKrGwgtTNv/vAlNkFnFdYPuvsTxhj6VVZF+SL+GM7dkqY05Dnw9pk1sUz+w489I/tCHVZK4bCgqrvFC2WlGJ884Z5JqXnbG9XWoEZ540e47E4GAvBC/4vX05kUxgxkutoiYLXiSJkNQIG0THXNHgLN13YwM1imTFcu3sBjBznjRy5OSU8aTe5n+Qz35lrISkv7FM975QhiILAb3JFqnxkvIF82ktcDk36SaMpVflmYGY01O4ymtsVKXdBjWnHfTd9xfg2FNthYxY2BMSS1eDWgbHXBuip7q9TIClh4QpJ1hoxthGF7Wao1mfKVDypXk7Ob1Jxq7jrJ/Y2TAAmHY/YPSANVSzxxxMh4bjeYKCvh3AHW22UwFjMOu2FReyN7IlcVoDScLRoMmWWtCOpkmRw6URVrvNcL/twIDbV2zpaUoQSBn/UB5k3m8jsiPF14yTCxSSDsOuIQonjxGFQC+oXuhLD1pCSEuwA+2BnoZgXoA=
X-Forefront-Antispam-Report: CIP:131.228.2.17;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(36840700001)(46966006)(316002)(54906003)(82310400003)(4326008)(4744005)(186003)(6916009)(1076003)(70206006)(107886003)(26005)(70586007)(2616005)(47076005)(36860700001)(15650500001)(44832011)(83380400001)(5660300002)(36756003)(336012)(6666004)(82740400003)(8676002)(2906002)(8936002)(86362001)(478600001)(356005)(81166007)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 07:16:09.7942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d04486-363b-4979-244d-08d94829961c
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.17];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT014.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6084
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Transport pathmtu can not be updated, when PMTUD is disabled
and pathmtu is condigured as fixed. Unconditional update t->pathmtu
will result in overwriting parameter configured by user
and lack of GSO usage.

Signed-off-by: Jacek Szafraniec <jacek.szafraniec@nokia.com>
---
 include/net/sctp/sctp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
index 2c6570e..0569956 100644
--- a/include/net/sctp/sctp.h
+++ b/include/net/sctp/sctp.h
@@ -612,7 +612,7 @@ static inline bool sctp_transport_pmtu_check(struct sctp_transport *t)
 {
 	__u32 pmtu = sctp_dst_mtu(t->dst);
 
-	if (t->pathmtu == pmtu)
+	if (t->pathmtu == pmtu || t->param_flags & SPP_PMTUD_DISABLE)
 		return true;
 
 	t->pathmtu = pmtu;
-- 
2.10.2

