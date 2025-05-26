Return-Path: <linux-sctp+bounces-560-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EB2AC3964
	for <lists+linux-sctp@lfdr.de>; Mon, 26 May 2025 07:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30F003B14DC
	for <lists+linux-sctp@lfdr.de>; Mon, 26 May 2025 05:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845121A0711;
	Mon, 26 May 2025 05:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XK97RIKq"
X-Original-To: linux-sctp@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148AB1A26B;
	Mon, 26 May 2025 05:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748238472; cv=none; b=u+Rh/Ayum8ikY5dQ+viHtIpMwsxYyw0UdOfVYb5wdeVOrGEt6/bqOLUeW6vdf1J4VsuEAP0YRbolxelLFvSJu8SJjquZ5Uw+vFNpzvllVU2JKCJhEM6lvPg+GUQXG+8+SI54sNeoZiuKREfKimdrg5H+4X5vZtAcFvEbvdZQrMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748238472; c=relaxed/simple;
	bh=3zgYVZySosNoDGMRGaKiw7o9cG2za3QzMZhu4M6vAe4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NY6gh/D6/DyVGZ7xB8JXCEhSN6qj++EGjgPmzUZZ4vRr0am2AWJ3LsY8HML0BuTJOmNavnXU1nI/m2v5PPvspfTFT6Jmmj2wgRH4Ra7BssPOZJVnadvIiQF4ZGpuC+WyhT6PodeWxXPWYx7elGEeMrc8y0MvQv1CaPtyeqyGZCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XK97RIKq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=DmKkPcCeN8+a79v6+RixZHwUOR+QcmiqQCtyMYfqtBA=; b=XK97RIKqxAKJr8fHIL+Ikq19UV
	4sNwB487LbZ0e8cKsp3sw4kOerOyGVcpauFUvsEEEcMKtjy14vGRYob3c0o55U5CAkEoEPgk0Y1Wd
	uhUMyncHuEkgEWaMjURD0NKMvlf9+udYa6sM7VR72ROCDkPY7Ay1GXXUiCU9kOe/Mt9VZOQEgiM6M
	AyLvR7OXvk69ZGabDNWRvz24qSaWKzgEBsiSO5Md7ZzcItW1V0koxQWwLYO8Iwz+4VsHjBc19cCN9
	8Jaw54C13fvKnxZLDwpgJ1q9PDDkHRD3xcXqU7geD9cKvbSaSOAAXJUfWYWtuEl9i0YWSUlPsR3zf
	skXS3p+Q==;
Received: from [194.182.23.10] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJQge-000000088uS-0xxk;
	Mon, 26 May 2025 05:47:48 +0000
From: Christoph Hellwig <hch@lst.de>
To: marcelo.leitner@gmail.com,
	lucien.xin@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH] sctp: mark sctp_do_peeloff static
Date: Mon, 26 May 2025 07:47:45 +0200
Message-ID: <20250526054745.2329201-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

sctp_do_peeloff is only used inside of net/sctp/socket.c,
so mark it static.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/net/sctp/sctp.h | 2 --
 net/sctp/socket.c       | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
index d8da764cf6de..e96d1bd087f6 100644
--- a/include/net/sctp/sctp.h
+++ b/include/net/sctp/sctp.h
@@ -364,8 +364,6 @@ sctp_assoc_to_state(const struct sctp_association *asoc)
 /* Look up the association by its id.  */
 struct sctp_association *sctp_id2assoc(struct sock *sk, sctp_assoc_t id);
 
-int sctp_do_peeloff(struct sock *sk, sctp_assoc_t id, struct socket **sockp);
-
 /* A macro to walk a list of skbs.  */
 #define sctp_skb_for_each(pos, head, tmp) \
 	skb_queue_walk_safe(head, pos, tmp)
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 53725ee7ba06..da048e386476 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -5627,7 +5627,8 @@ static int sctp_getsockopt_autoclose(struct sock *sk, int len, char __user *optv
 }
 
 /* Helper routine to branch off an association to a new socket.  */
-int sctp_do_peeloff(struct sock *sk, sctp_assoc_t id, struct socket **sockp)
+static int sctp_do_peeloff(struct sock *sk, sctp_assoc_t id,
+		struct socket **sockp)
 {
 	struct sctp_association *asoc = sctp_id2assoc(sk, id);
 	struct sctp_sock *sp = sctp_sk(sk);
@@ -5675,7 +5676,6 @@ int sctp_do_peeloff(struct sock *sk, sctp_assoc_t id, struct socket **sockp)
 
 	return err;
 }
-EXPORT_SYMBOL(sctp_do_peeloff);
 
 static int sctp_getsockopt_peeloff_common(struct sock *sk, sctp_peeloff_arg_t *peeloff,
 					  struct file **newfile, unsigned flags)
-- 
2.47.2


