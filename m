Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5263CD1B2
	for <lists+linux-sctp@lfdr.de>; Mon, 19 Jul 2021 12:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbhGSJeV (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 19 Jul 2021 05:34:21 -0400
Received: from mail-eopbgr20130.outbound.protection.outlook.com ([40.107.2.130]:62427
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235355AbhGSJeV (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Mon, 19 Jul 2021 05:34:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4Cf9WZxSl2kYn7COmP/TKmtyz17mGeAYtp9hFYQhmCPAdoJ1suVduTxENjGxMnoVNnA+xh6Y6Rv0INAOd0Dg3DkZ1xVb2sznoaHKkMaSW7wWAE+zg0lsdR3PJZHec9rsjs+4RU8YTWdTnneGcEuhzJhbK/spy0SJVbQQNxFbOVa/QPOeBymHvavn3mwt+ch8hSW3hvChjIKGu2hiPaGPpltAX5N6AOaWVTGkdmoUIyCklOS/Y+QSzGUCu5NOUbpogcR5NRzRdLPDSpNfMyICqSmXETqbH7NnnJ/6GEaFR7IL+MmkXSBAa/z9VGEqEMnnst+Sls5Cr+BQoXnfBbYaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eS6juyJUSxVQYhl2ZGlUhF9iUrEKq96qlafU36wcY4c=;
 b=nWxdVhofRHNLSHx4r0iqblPPgkX4BNPXk984oD1tPnvYYAn9hfeoqPPTSF/s3/H5sTyJ2TiklaHtY+zOqCft5FvPshnqqxu1gkS18J9FhymD240URNkrrPAhZvO1JanPijhvHdvnJSct5wCOuukrl2MCc+fieWKqb6SkMgRMhIW6fw6SGdGubgkgkVbBsrWwk9WFKVdVKdFEsYdEo761xTBb4gpQ2Oxdqk5y4gTsxv8uTtCelJt3bpYShK9p6IjUz5h7FynVfQmD/l1MAi2Y64hfBAqp+oT1AcBT98LjC9OLOefjDqRwrlmybo8pEdAmv0UZz5jErp0oQHqsr0kunA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.8) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nokia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eS6juyJUSxVQYhl2ZGlUhF9iUrEKq96qlafU36wcY4c=;
 b=GOgAuX0G4B1+iJVHcAlXM771pjr1egoI5f51jZ7YrFPNHZXqm47BHIyfr+/CTgqW4oALBjEtTR2GMo4hDECLyK7EfdbN60s+d6dVqwcf6zoLxpF2MRg8HSG1ysIhLKI2gJwue7d5iQ/9J30o3k+De/UgV5bK9II3gAIFQCsQ02M=
Received: from PR0P264CA0051.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1d::15)
 by AS8PR07MB7238.eurprd07.prod.outlook.com (2603:10a6:20b:25b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.13; Mon, 19 Jul
 2021 10:14:59 +0000
Received: from VE1EUR03FT025.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:100:1d:cafe::4f) by PR0P264CA0051.outlook.office365.com
 (2603:10a6:100:1d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Mon, 19 Jul 2021 10:14:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.8)
 smtp.mailfrom=nokia.com; davemloft.net; dkim=none (message not signed)
 header.d=none;davemloft.net; dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.8 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.8; helo=fihe3nok0734.emea.nsn-net.net;
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.8) by
 VE1EUR03FT025.mail.protection.outlook.com (10.152.18.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 10:14:58 +0000
Received: from wrlinb133.emea.nsn-net.net (wrlinb133.emea.nsn-net.net [10.159.92.203])
        by fihe3nok0734.emea.nsn-net.net (GMO) with ESMTP id 16JAEtv8004537;
        Mon, 19 Jul 2021 10:14:55 GMT
From:   Jacek Szafraniec <jacek.szafraniec@nokia.com>
To:     Xin Lucien <lucien.xin@gmail.com>
Cc:     Jacek Szafraniec <jacek.szafraniec@nokia.com>,
        "linux-sctp" <linux-sctp@vger.kernel.org>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Maciej Kwiecien <maciej.kwiecien@nokia.com>
Subject: [PATCH v2 1/1] sctp: do not update t->pathmtu when PMTUD is disabled
Date:   Mon, 19 Jul 2021 12:14:48 +0200
Message-Id: <20210719101448.30139-1-jacek.szafraniec@nokia.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <CADvbK_erBY5MmDVJwBi6RSHV4g_ZtirKpN12QJrN1eNvntRuCg@mail.gmail.com>
References: <CADvbK_erBY5MmDVJwBi6RSHV4g_ZtirKpN12QJrN1eNvntRuCg@mail.gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 70778887-3944-4629-822d-08d94a9e1060
X-MS-TrafficTypeDiagnostic: AS8PR07MB7238:
X-Microsoft-Antispam-PRVS: <AS8PR07MB72389A612F4B8F82A81EDD5083E19@AS8PR07MB7238.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sHi9w+/AJibqipZUScNKTo/ixQDsNvMQnpv6cdI3+4zOQveZe7FM+5Bh2y3UakAi4FFcN+0lRF8J0UOiHNur5Kol+B54kgLb6+KdIjt0slvrXJXziPVpMfUf91KJ74pf+68VDTyhmXzkjIHVz+OE3TpF+Pyg0OCMpbImySwA3xAH9WA/F8sNImNFTTS5oWQeEw9Om8c9ukKUdsUbGBl3g4gxHGZWVbHj7bQdA97quINngbEgJVzoEUy9+yZpeAiWDbKLfRtFai+ZsZnCrT6LzrOfO4r0gbLlw0II4lYi/WBWccwKRnpASL5aUemtBd36Ql5FDBDBQlpzs7Q7AASimoBsZyt9KYOZvJIWr3wBk5nDc6R4WID55MNjNhE6iVAqz3BOS79VFEVBhdKYw8IZ6NX1X5zQ48tuD239yktSBLwQr4a+74Nxk6bT1WUDXH4c6L3CpSY5kZmSu9c8hCR2uwouQ3fExXIbyQTmFrJPF99VsZ6sr6b/AqdRXoRFkmtp21+WKzHkz6vEN5iVB5IztwJVDsC65mksKaNX4APmTGPx4GNckOXNwJSCKze3Mz2sdRb0q6pVRd479dDjMN4qScZWZw3Er2z1Q+efuWsmMuoQjri8leiRsvt15BqHq03bWBmasMinL18GU7+LhVQN5A9dbCDnncASkoUdoH8RxX/KSWLZUOEYId/+BFqvlsu98Wgby711yZ7nSMACLvvGp/fkW7hWeQvjPyXuIlSCP6w=
X-Forefront-Antispam-Report: CIP:131.228.2.8;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(46966006)(36840700001)(1076003)(26005)(70586007)(36756003)(6666004)(2616005)(82310400003)(478600001)(2906002)(36860700001)(70206006)(86362001)(81166007)(336012)(47076005)(316002)(54906003)(5660300002)(83380400001)(356005)(107886003)(8676002)(4326008)(8936002)(82740400003)(186003)(15650500001)(44832011)(6916009)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 10:14:58.8744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70778887-3944-4629-822d-08d94a9e1060
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.8];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT025.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7238
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

>> Transport pathmtu can not be updated, when PMTUD is disabled
>> and pathmtu is condigured as fixed. Unconditional update t->pathmtu
>> will result in overwriting parameter configured by user
>> and lack of GSO usage.
>Seems right, the update of dst's mtu from elsewhere shouldn't
>affect SCTP either if SPP_PMTUD_DISABLE flag is set.
I agree.

>Can you please try to fix it with this?
>
>diff --git a/net/sctp/output.c b/net/sctp/output.c
>index a6aa17d..9f53323 100644
>--- a/net/sctp/output.c
>+++ b/net/sctp/output.c
>@@ -103,8 +103,8 @@ void sctp_packet_config(struct sctp_packet
>*packet, __u32 vtag,
>                sctp_transport_route(tp, NULL, sp);
>                if (asoc->param_flags & SPP_PMTUD_ENABLE)
>                        sctp_assoc_sync_pmtu(asoc);
>-       } else if (!sctp_transport_pmtu_check(tp)) {
>-               if (asoc->param_flags & SPP_PMTUD_ENABLE)
>+       } else if (asoc->param_flags & SPP_PMTUD_ENABLE) {
>+               if (!sctp_transport_pmtu_check(tp))
>                        sctp_assoc_sync_pmtu(asoc);
>        }
This proposal is better.
I've tested above. Result is OK.

Tested-by: Jacek Szafraniec <jacek.szafraniec@nokia.com>

Thanks!
