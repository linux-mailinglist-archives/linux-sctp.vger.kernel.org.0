Return-Path: <linux-sctp+bounces-5-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BED8439CD
	for <lists+linux-sctp@lfdr.de>; Wed, 31 Jan 2024 09:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65DD528EB4E
	for <lists+linux-sctp@lfdr.de>; Wed, 31 Jan 2024 08:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2EE6995C;
	Wed, 31 Jan 2024 08:46:10 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A3C69968;
	Wed, 31 Jan 2024 08:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690770; cv=none; b=udLkXsKhcRsuw1ngQIaX9ufaqOz5vSc1JAosGAo/3R32VxXvbj6/PdD2+obQ4f2BOg/wY4W8hG9AG8EUBp/PR19lePrOWDIBKKhTmG62QMNGjINXq0tFKQLiB7sk3X4pPL09KFHu1mrkkw6QtUm5agaAXBEUPRp6WRAmFPjyiw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690770; c=relaxed/simple;
	bh=C9y3ndyXZaoRbRNXMuMZ3OsYWUjmAu76jF09AJo+whE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YUHv2FL7qHPFTzrT5o0hA2UKVValyUZDXQA1sypjR6fc3iQR7FU6YDlVGIfMoGXw5Zj9vI5nBgO7eSo2h9iGhikHO0eHVG3/e2hGnFc7/s0b59H2G1MEL17AxvR/K7SCEKL3j94AMNDBcTTG+Tm38c5N8zlhEAl3nwLlJ8B57mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: cae85ecc1fd4424483f295ce66f8324a-20240131
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:95ae698e-1567-481c-90aa-ee649a018903,IP:20,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:30
X-CID-INFO: VERSION:1.1.35,REQID:95ae698e-1567-481c-90aa-ee649a018903,IP:20,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:30
X-CID-META: VersionHash:5d391d7,CLOUDID:baf7f47f-4f93-4875-95e7-8c66ea833d57,B
	ulkID:2401311645553AHGQ76V,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|44|1
	02,TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: cae85ecc1fd4424483f295ce66f8324a-20240131
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1902976999; Wed, 31 Jan 2024 16:45:52 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 1775FE000EB9;
	Wed, 31 Jan 2024 16:45:52 +0800 (CST)
X-ns-mid: postfix-65BA08BF-893949752
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 4AA0BE000EB9;
	Wed, 31 Jan 2024 16:45:51 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: marcelo.leitner@gmail.com,
	lucien.xin@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH net-next] sctp: Simplify the allocation of slab caches
Date: Wed, 31 Jan 2024 16:45:49 +0800
Message-Id: <20240131084549.142595-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

commit 0a31bd5f2bbb ("KMEM_CACHE(): simplify slab cache creation")
introduces a new macro.
Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
to simplify the creation of SLAB caches.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 net/sctp/protocol.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 94c6dd53cd62..e849f368ed91 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -1495,17 +1495,11 @@ static __init int sctp_init(void)
=20
 	/* Allocate bind_bucket and chunk caches. */
 	status =3D -ENOBUFS;
-	sctp_bucket_cachep =3D kmem_cache_create("sctp_bind_bucket",
-					       sizeof(struct sctp_bind_bucket),
-					       0, SLAB_HWCACHE_ALIGN,
-					       NULL);
+	sctp_bucket_cachep =3D KMEM_CACHE(sctp_bind_bucket, SLAB_HWCACHE_ALIGN)=
;
 	if (!sctp_bucket_cachep)
 		goto out;
=20
-	sctp_chunk_cachep =3D kmem_cache_create("sctp_chunk",
-					       sizeof(struct sctp_chunk),
-					       0, SLAB_HWCACHE_ALIGN,
-					       NULL);
+	sctp_chunk_cachep =3D KMEM_CACHE(sctp_chunk, SLAB_HWCACHE_ALIGN);
 	if (!sctp_chunk_cachep)
 		goto err_chunk_cachep;
=20
--=20
2.39.2


