Return-Path: <linux-sctp+bounces-707-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF16EC0C85A
	for <lists+linux-sctp@lfdr.de>; Mon, 27 Oct 2025 10:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2785189995E
	for <lists+linux-sctp@lfdr.de>; Mon, 27 Oct 2025 08:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4042E764E;
	Mon, 27 Oct 2025 08:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="RfbgPh/m"
X-Original-To: linux-sctp@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011014.outbound.protection.outlook.com [52.101.70.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C282E3B1C;
	Mon, 27 Oct 2025 08:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761555023; cv=fail; b=VbgD0uH/nWff21oNpPvfBmhZBSV5fsSdsZbkakmpP1c+gdis/Cd20eQPNvcKuWYlNcV8FnAUenG8VNehTT/X9qLy8WhsFh5MAEQk9v6/5qqptfa7+SHAhpznNokluFQ+IxkqkNgVJ7CJLdO+tVXwR1/dyl7a6meSbiYi/18+IOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761555023; c=relaxed/simple;
	bh=jfySb+SEqIoIofl2b3mCapa2Zxha/u9HH14lbU4q0HU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XyngazkUrUJ7ZPPsN1ZYOcMlQTFBuAIYMagNw0APMdEa6iVFMgb3gtmLNZt8B1gSpgSLaxdwD9kTjigh14rYhreoyF2Qp6+cMNt7XiPOZmCWakpHo5d8M/tu0sFc5H8XBVLgb03uiDOG4Rf93hOtLFknDxHsI/VzU7p81PThcR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=RfbgPh/m; arc=fail smtp.client-ip=52.101.70.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sy8dIoE/Gt4QxPu3zuivIBm92wyZFOlYEtncgptEZRpHjaRSg/lROlO7ScMJt0CP41bOa+rHwPtpCbI7njHdjATXgq1PKDKZUGe5r4JEF5eTVuO4vPcJMo8o9alJKhq6g6SGt5zYM3C9eso7dR/CMmOPWjNBQhI5cizXFrNagE8NhfGQKRaHVXTy7dStoHsY7sHEa6GbR0X5JQp8qrdWjhwuhKUrSIEWUlp0oXuQ3hY3puAo/sBnb6+oBlbmSeISR0VGrMFCqPnnQH9QkBoxc2rTPG9ysq5noj/4uCLJKnNmGYZSRDjACnASHGcLsl34VQXxuFBPteFj7zPRJ4Iocw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gzeqEGj63yXK9Rf/v99FuswmdroQXSKxtG+IWtPlnM=;
 b=ijmFwRz3+h7KIQofcsZ0xsFrSkpiN2N8hEdLSJ1X3FOVvaq6OhBwrKb78kkcF+mF28QXLl7Mqd7oApiwkO0YG35xE8vGFMmlg/b0N9hmtU8FGQhNEuaCld9h2PHCiLdrjORUBN9rD6mezKjyynPrZ8ekQyTUhzEeQ7PkQNZWXVANvyZF8+WuqP0P2PWCbopWMEBS3ead7khiYuoxvS7iAkm2qIASSVsFpCgfGIA30yn8ZIozwv58aO67BH2TfGQF7fTzqCr9WLVo5o7Nn9jzHR+jk7w3KqK6HT+b5engjvP0YiAk6rFsyp6YW+f3r5F5pUBCrAPL32/a9cJV+AnD5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gzeqEGj63yXK9Rf/v99FuswmdroQXSKxtG+IWtPlnM=;
 b=RfbgPh/mZP8UfXyEVmitGmYtdGVq7igCIGKeA5YR2Hcgi1APtoMHG3Mj+l0c2JOJUoFVHNv38B7d0hKiKsA9HoBN9TPiwbS20JoDI9Ua7WU2s3DMKW3nkQisqgkFCtkXJf1OhvXphEhpwW/L88Z/e8QyKXAZrjliGtADOK0tl/o7dA0/low+h+2/xmSU6IJPsk6sCYHfwy2scmIve+0lU7dhPPXxQnLgJ52BrNw/+PYhNi40KHYTnvyTqlbz6OUE31vtkr/Nb4NjAvTG5N23N4WcK4W+/5JWgi6YMB5gxYSVkFjt+DFOBJpn2lb0rZf4+B30n942+CXaQ0x4fIdOZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by AM7PR07MB6611.eurprd07.prod.outlook.com (2603:10a6:20b:18f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 27 Oct
 2025 08:50:19 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::3a2d:5997:c1c7:3809]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::3a2d:5997:c1c7:3809%6]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 08:50:18 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: Xin Long <lucien.xin@gmail.com>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH net] sctp: Hold sock lock while iterating over address list
Date: Mon, 27 Oct 2025 09:50:07 +0100
Message-ID: <20251027085007.2259265-1-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::13) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|AM7PR07MB6611:EE_
X-MS-Office365-Filtering-Correlation-Id: f8867b5b-79ac-4003-e230-08de1535db02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+wXlo3aKvI6ajXoA51GZ1mhGNB4g9ACW1+37iQGc2gnVPUW4bmN4CrmpfMg0?=
 =?us-ascii?Q?TZtadGWNVb2Ln3wKz0i1T6BJpvY+apsLvC0Z1GlSjM6FtWSWaknlNkWzuMxB?=
 =?us-ascii?Q?2r2hQOqeyUZBVJcRd3Kvg1qkPD/W6V504c9dUl6WO+oBwBgViPiH1vIilLSh?=
 =?us-ascii?Q?E3K4UiaBPbZYDbUquVVFA3fyg9+fPeoSAMe2hld82+FCo7byufn9orAUi6hm?=
 =?us-ascii?Q?CZAv1Of5C3znMNW4ZRmBa3nZCkcdTUNH085XIyknWDHiHS6y15kBr4FJiqcw?=
 =?us-ascii?Q?CJE3TFSVD0fgglCoprsb3Q0lguPw6KOwvYX85MVTVrmO1b06VYxZ5v0y++rw?=
 =?us-ascii?Q?Ru+8Oip6zvyjtzOcxoCgkctkxr4iJ3HESZBtF5fDkgH6K6LcIwXycERWIrqu?=
 =?us-ascii?Q?TPPZ0lUO4tHxjzGlAseloS4pDvKecR1XF6UGdMGrvLW8n6g4w66gnbozTJ4a?=
 =?us-ascii?Q?/oLAgkmtAYGXML9v7bS6HmX5tQGvQ/SjYR01CQ78hJ8/DAH8USDQoEQuZqTR?=
 =?us-ascii?Q?NhWmBQKkKjb5ADzcLHo//IdJbbi2fG0KLfWhorHxh57+3LD37Jtm2ucukTCj?=
 =?us-ascii?Q?djisZlj1nyojW44dwglGJWRKEnhYg/9QEshsMkBevq5QQ6wPLKIHts8rHemb?=
 =?us-ascii?Q?RTAjDU9rCkSeySknF1KflVxmwJ7wLEHv/oICUjP7HIJWKsL4oFjWJDGSbLPc?=
 =?us-ascii?Q?X2J8nM0kfYi2kNIBb7WYieQltatXoTfBPkMtNsJpqjNM3TQmnM0n6RDeLoXf?=
 =?us-ascii?Q?pDNuXjy62naBVmzIJgwrtDja9DWsy7owK1F93zq9Q9jko3p/x8R5A5NGeWHO?=
 =?us-ascii?Q?zdVotY2kOoCkMwJW1dtERVN4okpXPe23ZsJUdmHovxgg6aoOORBDV3q1LAIT?=
 =?us-ascii?Q?rJx1x4swEQR2yxV7DFFN1ulQkx2W3CVgek1RwZo+3ifFf9naVFAs/6i4i6gK?=
 =?us-ascii?Q?9lP2huRlLDnD6zHc0Gh59SvMuK1oRt2nanpucT/ThLcCIQsbWO63uJkoEmUH?=
 =?us-ascii?Q?V6pO7Eqbhxycj7PsKBsddPej68ZToBhqj41UYLshxS64TRQ6DSplb+giaFng?=
 =?us-ascii?Q?0IVe8A/Wbq7qKNXnLyr+DG8KZmLtqWuF7VwsMilh17yT9k7fb4CniDaISa05?=
 =?us-ascii?Q?PhhN6m21alJ7klgNBHcnq7wu1XBuZ/F1neXRMaMzYQ9oVEK+IuE0Mz2E96b3?=
 =?us-ascii?Q?nc2rw0CShUbv4g/EH7/b4TApuEiyvgkcnsfSFlZrJR2mJd0uPCGuxNnWFUXo?=
 =?us-ascii?Q?Z4ze2B9SNKnGNmhdIP61R18cSGeFU7iuwNqEwx46jS6VwUVpocYgMC4tPBJf?=
 =?us-ascii?Q?hkQpopKuVlzwstwv+ZpVvep8QaBOhWITNR9p/O3AccnmyVENBCbWZIbMmFfg?=
 =?us-ascii?Q?GSpLWMqaXhvt9mlwdebjDrMKEXRlcCJ0wEfcSyxgK0H9aUsQMgCPKPu8b3B4?=
 =?us-ascii?Q?uM2Wk2J12MXQxP5o7WMjY21Zmsf0MYJ2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eviWALoVBBhQaH6x9GJhE0bDenAh7PPc7Hj08uvNM05f3JVaD7wPHe0uVMgl?=
 =?us-ascii?Q?y+GjhoCJfTTLw/OCKykkTupsu7QMVaKmT6euNcY0wtC6ENry1+7gxLK7fU6p?=
 =?us-ascii?Q?VEM/XT+i137dEntufiU4ePYDei57nbgZ5PGMmOf9YDD8N+ASW4TcO9UVtIqF?=
 =?us-ascii?Q?Nigvaeg3JdJ5hjyXbth1OIiP9kNOF3XigJHFVE73m1OzdsG0f6zNBgCKqFjk?=
 =?us-ascii?Q?elWKNp8j15ZcDZG6QGokHpawFf6o9zgVoBaDGSjd4CVeytous51q1ao3KbjN?=
 =?us-ascii?Q?WmYsJhH8y0+f2IHDC5Fi9GlwiJev49s2DvSfk1ktV+Cn8/8pSsCw2P5YjQUl?=
 =?us-ascii?Q?gqfjp4DQKGWVNO+gortqvPLReoL94RZRet9tjIqkqRvUMdViG0yzuzXS/y37?=
 =?us-ascii?Q?kk8En/x+IoRIHSIcVENxNzZAiGEcqN6WfgSk4I3pXOWxhPx0IZGlY6uzDJ9+?=
 =?us-ascii?Q?UpQ9FJo5CZ3imuZVKw34sHGi97rwOeSDPI0latyRtC6tkrI6DUjZrMWKi/As?=
 =?us-ascii?Q?nU211kDhpOsxR79Dity6EEkiDnNKWafgN7fROutufnZjdCs+TaAaj2gI1qmU?=
 =?us-ascii?Q?fWIG7gtCPp9KwQ4fXCQlHqbHJcZ6CuMDKaMXL3NKTmje6kw4eGGRPM6cwW8c?=
 =?us-ascii?Q?E1JonJgHaLb98F0Z+VtJj+4+vF325HFR05Di257ptvqO9nMIb2TTJKXkjy/Y?=
 =?us-ascii?Q?7ThlDt/1yIA3lefq/9wDiJ9muciwEAoJcDTwA6b6D4cAnuEGu3UnGc+giGu6?=
 =?us-ascii?Q?PGqqnu0FF0HoHjVSV2AdSkhA0OrlkOZNm07zL80lgJPuiXd0B8qRr1bBYcU6?=
 =?us-ascii?Q?66dpp2vay5UgM7PiYgvVN2FtI158utHZDVj4foiXWUkmYTTkhh9BBQBfUoqw?=
 =?us-ascii?Q?Za5fPXdbGQQAy+E3RQRdvO+7YO8JLVMPv7c+MKl1/QB9Id844sUHlKjudnV4?=
 =?us-ascii?Q?kNxwiTK173QVxVTO1uRgeqIiPG7o6Nn6Ta1sjbDvp0xsFb4INIkDLU1G47je?=
 =?us-ascii?Q?HSEkXY1uJUkfOT3p0wXHpSFCFfhovxJvTeGrL2NewOEWX6NW/SapnPsCykFV?=
 =?us-ascii?Q?4DgH58LzULEF29D4dvQP4XB+jNxhHUTOpwNcqRD/9EWF+R+nubZRcvZD4qPo?=
 =?us-ascii?Q?clk7sR9GXgMYKakXVoPW4uMwSoeXHEOZ0svmp/2MSLwFeKjLcnm9BrCxl8pu?=
 =?us-ascii?Q?Ququax2Ris+YjYSXU0svedntwbdW+69+z/a1fh4Kp7FKi6mg9cBVxo4NE5Ko?=
 =?us-ascii?Q?To0NdNWqO6Qa+u48CmGEcNGgbadbs1BqwgszHAteJhKev7rAUWnklJR8SuCo?=
 =?us-ascii?Q?QtgajFrz2FyshqpakaU4Djuon38eCz+FUmFxLe5keJEvO/t2w8Qd8Y6uF+Eo?=
 =?us-ascii?Q?5Yj/q7fB++sAgjvkpXBzITSRdGeocefzWwEX+3aUyybw2I6ZNnLS8ASxWzP8?=
 =?us-ascii?Q?cNn6FM0bj/MHBxb42l12YBogcQSpPH4CGGRxWhTk/iQH1Ijbur3uN3oYNL6o?=
 =?us-ascii?Q?VVJot1PVe6L/dgNbFfghIxuL6syBn9sZTtkDwmhF8kGalvzuEuDbIo4UrKJ5?=
 =?us-ascii?Q?e9xXX3Wy16IcU8+Wh36RWbYxLcIVbMCQEiepaCSleVIDK1/Qd/V7XGvus2zq?=
 =?us-ascii?Q?MZCd8F7ZnfCCm3HbPww8vsrjSD4vf5SDYWVLK4E0OXeJhSKlIrhCL651T4lZ?=
 =?us-ascii?Q?4MweWA=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8867b5b-79ac-4003-e230-08de1535db02
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 08:50:18.8086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2x7EwzsTqlefwcCNoJNkmbQfVLfDVUGa0FKLkXVkYGfz1XA5t9HW9MZom5NDE9e5MoFM+N6qwzBN3parhQZtsbzD+lH8ssDWRTX7D6QE8Ho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6611

Fixes: 8f840e47f190 ("sctp: add the sctp_diag.c file")
Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
---
 net/sctp/diag.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/sctp/diag.c b/net/sctp/diag.c
index 996c2018f0e6..7f7e2773e047 100644
--- a/net/sctp/diag.c
+++ b/net/sctp/diag.c
@@ -223,14 +223,15 @@ struct sctp_comm_param {
 	bool net_admin;
 };
 
-static size_t inet_assoc_attr_size(struct sctp_association *asoc)
+static size_t inet_assoc_attr_size(struct sock *sk,
+				   struct sctp_association *asoc)
 {
 	int addrlen = sizeof(struct sockaddr_storage);
 	int addrcnt = 0;
 	struct sctp_sockaddr_entry *laddr;
 
 	list_for_each_entry_rcu(laddr, &asoc->base.bind_addr.address_list,
-				list)
+				list, lockdep_sock_is_held(sk))
 		addrcnt++;
 
 	return	  nla_total_size(sizeof(struct sctp_info))
@@ -256,11 +257,12 @@ static int sctp_sock_dump_one(struct sctp_endpoint *ep, struct sctp_transport *t
 	if (err)
 		return err;
 
-	rep = nlmsg_new(inet_assoc_attr_size(assoc), GFP_KERNEL);
+	lock_sock(sk);
+
+	rep = nlmsg_new(inet_assoc_attr_size(sk, assoc), GFP_KERNEL);
 	if (!rep)
 		return -ENOMEM;
 
-	lock_sock(sk);
 	if (ep != assoc->ep) {
 		err = -EAGAIN;
 		goto out;
-- 
2.51.0


