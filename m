Return-Path: <linux-sctp+bounces-300-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F09539FFBCE
	for <lists+linux-sctp@lfdr.de>; Thu,  2 Jan 2025 17:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C7C81883A42
	for <lists+linux-sctp@lfdr.de>; Thu,  2 Jan 2025 16:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B241B140D;
	Thu,  2 Jan 2025 16:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P4JEZ9qU"
X-Original-To: linux-sctp@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A9B158D80
	for <linux-sctp@vger.kernel.org>; Thu,  2 Jan 2025 16:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735835668; cv=none; b=Oqh8DQGK5h+DxL8FjFiECOmuzMwiUV7YYoLSo9qst2osSfW+VRIAkXKr+DdCmUok/RNCBh+u0dmUufoVhyrdQMFQYT8bn0Bci6OQQBMlDJU/IJj9yyFAWBlbe7LcVG5DWwME+0w3u/qi8lw5/qE/ejDo0ORJZMKjXZKPpc0NK5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735835668; c=relaxed/simple;
	bh=hH2VHk5usEHWu2muac3LnMYM+2kmRkbt79tL6mJTEQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q6XL4yRX9+8KL+19DgcUQPmhw6XGLiT8bOy+rzKH4I6rUJ9Z6VG7CCL0TAbxl+Z4BeYGhrgmcglXQX2L0hG7TqF7NQEfph+qdmoxedeUKYqhXHxX58/oloTFVCPyA1mQXcc0DJnsa92ljhWhUFWb4bj3YMYbwBUa0pOZYrD7m9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P4JEZ9qU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735835663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ZTtTZ+Q7MWtFriTpa2LNQ3Z0EHdCKnkW+osilKQ7/NA=;
	b=P4JEZ9qUl5zwFQA7fUpCOZxsvqTqSVnCBVqrR69jqCVdKH59nU7xHNrvq7YZOq0ISVH901
	eRWm/c3+1dER7NWrFPFbzWZLIArwrvoJ9/T8kE2QOE7rax5Dr1QSMnGiHX5lblzM3rxrva
	89UiFiWt3bf8pD3zL3sSbSJI5e0WpCE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-1ChktQt7PL-UQBBCGjgzKQ-1; Thu, 02 Jan 2025 11:34:22 -0500
X-MC-Unique: 1ChktQt7PL-UQBBCGjgzKQ-1
X-Mimecast-MFC-AGG-ID: 1ChktQt7PL-UQBBCGjgzKQ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4362b9c1641so57695315e9.3
        for <linux-sctp@vger.kernel.org>; Thu, 02 Jan 2025 08:34:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735835661; x=1736440461;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTtTZ+Q7MWtFriTpa2LNQ3Z0EHdCKnkW+osilKQ7/NA=;
        b=aRswZMvIGXPOkfaUbFR6rW0X2poR9E6UdWjJoR/fGFuPga2GdEkbHk7RNscDmzte3h
         3KBMLRvazgGV2L9RPuO1sN+FmVvHdUv0aftdPDeclQaMU1JGoEgd7lSnpkEfifA8yH7I
         7ksAYs6TCOfDeClyFbKN0vLuWG6HqKfJE4gHzXM3BdDwTgFJ3hBxjAeyr7MSVIav7AEu
         zUIP6Wh28Tpz/ZxsDAuenbiwz8JAJeHWP+/ZN7T9VbG0mhPvatU891Bu2+kG/kxqPD8K
         osqzBuM5u9FYT7XNNU3n+4CThaok/cCvpyJEO2Cr3D+d5fzT5Cj1RQAEBa/9iRqEWWDJ
         Z5vw==
X-Forwarded-Encrypted: i=1; AJvYcCUuB663JYy4KY+HTiWT42JnrM1MIC4M7By82KNPcQzm9jxTQwzB/My3gxPcIyrvyMRxSb6QIpmHGr/g@vger.kernel.org
X-Gm-Message-State: AOJu0YzFJnKMahpxjkOcmen2DfpjqXtDG7ml2X4VBcoga7G6WlElm3Sa
	xb3fgUrwDJSHRpTPM9/TyGwbBs4+4Rp21BwjvbWpZ9iHun5A4+iCzYfnmG21RLD6kUjK+s7Tw3g
	QEz6EYTF0vmwfJSvDEj16zk20GaCF0xDbFeGGTRPyKwRwYtMjoxr08uHvUMM=
X-Gm-Gg: ASbGncvAPLwKVrPUELkMRIlINSDzcA0TTpsb/4uKjAEFH0yBauwaQ5XlWLSlldvC2KG
	PkvYRhTqhbxRxYZ6f3UdUyyCdrsCeaMFKCcjwuC6q85xwwne7vzDDEXRrCI9D20MvYEDXYShg83
	Lj3xXbC+Uqo6E1JaBnu2z/GZFg72YIhEJuYcfMCa/rr0NJ2RNshlYktpA92xy5+a95pUmmM1X+v
	Y74tw2DUU7TOS6G7U6YEEf4GRbuX6SWVlDJ4qcvLU4ZJG9kw5R+OivciGSifQXuuWK61pu9vVb3
	fEDDWPq0bk0fQYV8FpmN0Tj0lfr6/nMxbqg=
X-Received: by 2002:a05:6000:4012:b0:385:f195:2a8 with SMTP id ffacd0b85a97d-38a221f9fc9mr33164864f8f.30.1735835661101;
        Thu, 02 Jan 2025 08:34:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE82nvsTgcC6Yh/J6pBWP+NUJFHG2DaGkuhdzr+X/l4tLv8nl1pe7JeaOJel4VOyRqm6REp2g==
X-Received: by 2002:a05:6000:4012:b0:385:f195:2a8 with SMTP id ffacd0b85a97d-38a221f9fc9mr33164846f8f.30.1735835660757;
        Thu, 02 Jan 2025 08:34:20 -0800 (PST)
Received: from debian (2a01cb058918ce000d2a50ec66dd1898.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:d2a:50ec:66dd:1898])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e2eesm39088130f8f.80.2025.01.02.08.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 08:34:20 -0800 (PST)
Date: Thu, 2 Jan 2025 17:34:18 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>, linux-sctp@vger.kernel.org,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next] sctp: Prepare sctp_v4_get_dst() to dscp_t
 conversion.
Message-ID: <1a645f4a0bc60ad18e7c0916642883ce8a43c013.1735835456.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PKT9TC2vK6Axt4Yd6YHV8fkf9PPqwye3mwEbrlRphRo_1735835661
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Define inet_sk_dscp() to get a dscp_t value from struct inet_sock, so
that sctp_v4_get_dst() can easily set ->flowi4_tos from a dscp_t
variable. For the SCTP_DSCP_SET_MASK case, we can just use
inet_dsfield_to_dscp() to get a dscp_t value.

Then, when converting ->flowi4_tos from __u8 to dscp_t, we'll just have
to drop the inet_dscp_to_dsfield() conversion function.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 include/net/inet_sock.h |  6 ++++++
 net/sctp/protocol.c     | 10 +++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index 3ccbad881d74..1086256549fa 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -19,6 +19,7 @@
 #include <linux/netdevice.h>
 
 #include <net/flow.h>
+#include <net/inet_dscp.h>
 #include <net/sock.h>
 #include <net/request_sock.h>
 #include <net/netns/hash.h>
@@ -302,6 +303,11 @@ static inline unsigned long inet_cmsg_flags(const struct inet_sock *inet)
 	return READ_ONCE(inet->inet_flags) & IP_CMSG_ALL;
 }
 
+static inline dscp_t inet_sk_dscp(const struct inet_sock *inet)
+{
+	return inet_dsfield_to_dscp(READ_ONCE(inet->tos));
+}
+
 #define inet_test_bit(nr, sk)			\
 	test_bit(INET_FLAGS_##nr, &inet_sk(sk)->inet_flags)
 #define inet_set_bit(nr, sk)			\
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 8b9a1b96695e..29727ed1008e 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -43,6 +43,7 @@
 #include <net/addrconf.h>
 #include <net/inet_common.h>
 #include <net/inet_ecn.h>
+#include <net/inet_sock.h>
 #include <net/udp_tunnel.h>
 #include <net/inet_dscp.h>
 
@@ -427,16 +428,19 @@ static void sctp_v4_get_dst(struct sctp_transport *t, union sctp_addr *saddr,
 	struct dst_entry *dst = NULL;
 	union sctp_addr *daddr = &t->ipaddr;
 	union sctp_addr dst_saddr;
-	u8 tos = READ_ONCE(inet_sk(sk)->tos);
+	dscp_t dscp;
 
 	if (t->dscp & SCTP_DSCP_SET_MASK)
-		tos = t->dscp & SCTP_DSCP_VAL_MASK;
+		dscp = inet_dsfield_to_dscp(t->dscp);
+	else
+		dscp = inet_sk_dscp(inet_sk(sk));
+
 	memset(&_fl, 0x0, sizeof(_fl));
 	fl4->daddr  = daddr->v4.sin_addr.s_addr;
 	fl4->fl4_dport = daddr->v4.sin_port;
 	fl4->flowi4_proto = IPPROTO_SCTP;
 	if (asoc) {
-		fl4->flowi4_tos = tos & INET_DSCP_MASK;
+		fl4->flowi4_tos = inet_dscp_to_dsfield(dscp);
 		fl4->flowi4_scope = ip_sock_rt_scope(asoc->base.sk);
 		fl4->flowi4_oif = asoc->base.sk->sk_bound_dev_if;
 		fl4->fl4_sport = htons(asoc->base.bind_addr.port);
-- 
2.39.2


