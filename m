Return-Path: <linux-sctp+bounces-1265-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GZPMEI+bMGp6VAUAu9opvQ
	(envelope-from <linux-sctp+bounces-1265-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 16 Jun 2026 02:40:47 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D5C68AFCB
	for <lists+linux-sctp@lfdr.de>; Tue, 16 Jun 2026 02:40:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JQmTTows;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1265-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1265-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31B8B31165BA
	for <lists+linux-sctp@lfdr.de>; Tue, 16 Jun 2026 00:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E39A27057D;
	Tue, 16 Jun 2026 00:34:23 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2286E25B099
	for <linux-sctp@vger.kernel.org>; Tue, 16 Jun 2026 00:34:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570063; cv=none; b=nixynEcJUl1A7uHCNsgv4fUMoDlirCv+NHz5GqmnquYZkdxZC//fJeYfLCkchhCvKHbqBvPUzQN4zvOsmC4b99x0IQklwlqTZU8OVh1ZpkDjvr7TbeSjQorHXemUlWMcx+mfFkg8qiN4o9/h2RQK5/zb+uhElT+AngcyEvElBmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570063; c=relaxed/simple;
	bh=0LmyQ00Ck04jQaIqLZzJpSz9VfDo7KjmLZWdKrbv6cM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aBBBlXT5xYV+1x32zWtqaNVfOlFg9lpcq3Q9b+sl4eKhVPC3mlfG6CcUiLK24y+G4iU/f6vqTP6qJeTFmiX8GBjeQORo0nan+Mygrj3gSkswEm9QSqsboBUdymqX1bk2dVX7Zft6iGdIEgMwuNLcxxdMuPxJxfHuLsporKmw04o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQmTTows; arc=none smtp.client-ip=209.85.219.50
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8ce9ddeddefso47089176d6.0
        for <linux-sctp@vger.kernel.org>; Mon, 15 Jun 2026 17:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781570060; x=1782174860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j6yM1xk7ypP2XlTdzKi2NbwQFcEcc7IeUirVA4naqQo=;
        b=JQmTTowsOHxNPQ+6RqGJkoV7n7PHnMVxcbij/xCkz7bCXtRNfrM7oSMTZfh3svu8Sb
         t/iIKig9ACHFfF2bhf3X27i75QjnvO5R0sxmaCt1R2UQuP6sjIsb5VDvCHhdYhZoUeD1
         Qi0ra+3hD6QlRORxHlKTGp1d7Pdw0tSXIbRWTTDzkSLpTbTPK6Tem3ahGVG2aTe1M0DY
         FVUTTXZ9ME3vcRqUrULgGyYyUis/ltEgwtxxNp1fcB9jb519kdV/ov4ChEDNj1xtDQf7
         sJuHTj9YxnaoRbLMmCd3/5/fNaC5+n3MoLVjTIAlUdKcvDUkJGndOHTuEq3kJkcoFgVT
         bK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781570060; x=1782174860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6yM1xk7ypP2XlTdzKi2NbwQFcEcc7IeUirVA4naqQo=;
        b=Nmhkm+w5jCC4lCJ9U6WRuLnFc/UN6knNMObLfcyumexMExiXCx1ZvholMVuqJv4OuI
         A+mJ+x/2WKKFjuOZWZqBJnVbBwGwTAfN2URXEI0QLaihh4DuAKbhQgUf/e9fFGwRoWX3
         4+iZBz7mywuDY9WPSPDuBEOn2vlSPFmHJ+pA0xLoMUVUAC3qHtsdJGhKUM10QcwcACQJ
         +/ueB7mwvXGN2+WtzQ5A+0KDMkGCwJid6GqzaNK/wbBjLVnqPkKuvNP031KqNLvqe4kZ
         kOwY3u2iNqABE4VDlypBG9EoPca4BL/CLDh0xlRO+04j9pQAqKyfxknKT2lYw2LSlr2+
         R+MQ==
X-Forwarded-Encrypted: i=1; AFNElJ9sekWcMqmJ4Fw9/5YfaSX8k1lqXtDjjVR5DGswuG7aSA4+8R+COvH7VQc4dDioVCuDzEijARbfQRsN@vger.kernel.org
X-Gm-Message-State: AOJu0YwWPKTRnOt7pQ+dc8F6j2TssUtSrMOn8xWh6LTMo7c1WL2qNcrI
	ydo83K/SGszINrNCCiw7QXq1cMS4iIiA4DIxE6EHJf86XLOxpy72MWze
X-Gm-Gg: Acq92OFNaZVC2awcQKbOUfi+N2JOMU/mnie37p+yO4chLrtstNn4HFJCUkeNNNTg8GC
	R2yJ3NHyDcMsxKkKWZlDRjOssZuY4x0TXlbXTNwv+DFSXqQMIEon3icXP6icWDmN/Kyd6RxPdRY
	jhOtpbFKDp1N2LjC4MEUFUz4BTqGNeQPU7EyOFDv+a6RKK7cEixA7LRIHgOVu10/F1KTdRtmbpA
	x/d1YWM7H4Yf2a3ngCp5Ufh7DLfWcgRz39KTZ0iCsIppFT9W0Ux1gpwfRJtO6X1985s1PNgC7de
	FiWsNzEdTuYQ8W1W5V6/5lDAXE1vYjogb1lmHnZy/ms5JdKLJ9eowToRFAaekcjHw/DoLdRTlxL
	KV8zo0kSFF9fGQfSuLFwLL+56+i5wDVMqMgzMCqMM8ADt98VAdCz3HkRE6GABNLYk991bDXWuum
	hq+JlOdmzh+xW8GkL6Jst7L2DbHVk0mMELbjKwnB3if5p3Z2zDpd/zxRwBw4/Fb7AAKMahLscMS
	HqAuvFwcX00s1LBg4e4gmp6wGXJIOePp2rRdoB63fAEP9+EiKRGqUjoVvPD2CF9YDbwDdgmM8UN
X-Received: by 2002:a05:6214:500f:b0:8ca:1ddd:a6b8 with SMTP id 6a1803df08f44-8d32c7ce63bmr291687616d6.14.1781570060080;
        Mon, 15 Jun 2026 17:34:20 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d9f132178csm16794326d6.7.2026.06.15.17.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 17:34:18 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH net 0/2] sctp: validate INIT in COOKIE-ECHO when auth disabled
Date: Mon, 15 Jun 2026 20:33:32 -0400
Message-ID: <cover.1781570014.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-1265-lists,linux-sctp=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:marcelo.leitner@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C2D5C68AFCB

This series fixes a security gap in SCTP's COOKIE-ECHO handling when
cookie authentication is disabled.

Currently, INIT chunks embedded in cookies are not re-verified after
unpacking, creating a vulnerability when cookie_auth_enable=0. This
series first refactors error handling, then adds the missing validation.

Xin Long (2):
  sctp: factor out INIT verification failure handling
  sctp: add INIT verification after cookie unpacking

 net/sctp/sm_make_chunk.c |   2 +-
 net/sctp/sm_statefuns.c  | 200 +++++++++++++++++++--------------------
 2 files changed, 99 insertions(+), 103 deletions(-)

-- 
2.47.1


