Return-Path: <linux-sctp+bounces-190-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4958D94367F
	for <lists+linux-sctp@lfdr.de>; Wed, 31 Jul 2024 21:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE42E1F230E2
	for <lists+linux-sctp@lfdr.de>; Wed, 31 Jul 2024 19:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E853049627;
	Wed, 31 Jul 2024 19:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LpDThtnq"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406D674BF5;
	Wed, 31 Jul 2024 19:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722454420; cv=none; b=srJXp/DygqWC0TW6SRycysgpFsMrcHzYEwONofvup0I9shmtNnwI0ZInKGTsEcXI8q6H8qZsZX8MhAJ5qzPjvKgxgMEKaXHg8cyscTEUoxorZ08GjPgXflWsMBJsWZS//jnlqJIgogdVnVDFW9jzGEei1nZUy3nig5H8QiIAczs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722454420; c=relaxed/simple;
	bh=4PlHmsM3FQt26blJeNLEA87TMnezQ6Iuw7UxBqioTpE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZLbOFBPB1sv6qrB13vOf+od+HWoChRb9yXwcZUvZ9Vjr/ZMMeOndiG33YTS9WnkdPBF9RazG+7vL/E+lzuC/hCDkGSz3BVPEc5CCcOowAFCTFha/JZn4K2+13TV6WIzofpAx5bmRI/Z8aompPENvDSv2Q0oSRxEqW3J6YdC3vlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=LpDThtnq; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722454420; x=1753990420;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=20hseSQZQEYnHzF7tNE/CM8oaeuo76nSj+rUoArXozI=;
  b=LpDThtnqz9YNoxEdwWcPWqXv185l12Zovlk+Hjj3AGbx45SqECFPL1Gl
   qTghWrmvXLbAkq1lWXn8ZvjMrOLy+MRsRIR9jSCqnLjSWmzfVflT0GbKw
   OFKyZsW7v0ZrCA85hj0fnftd9WUZ3FS9fVxSZW8g8z9eKfYXAXBXRNRNG
   s=;
X-IronPort-AV: E=Sophos;i="6.09,251,1716249600"; 
   d="scan'208";a="359841462"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 19:33:32 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:23415]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.75:2525] with esmtp (Farcaster)
 id fae5ac27-a9b9-4f1c-8702-aa873138a367; Wed, 31 Jul 2024 19:33:30 +0000 (UTC)
X-Farcaster-Flow-ID: fae5ac27-a9b9-4f1c-8702-aa873138a367
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 31 Jul 2024 19:33:30 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 31 Jul 2024 19:33:27 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <dmantipov@yandex.ru>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <linux-sctp@vger.kernel.org>,
	<lucien.xin@gmail.com>, <marcelo.leitner@gmail.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzbot+e6979a5d2f10ecb700e4@syzkaller.appspotmail.com>
Subject: Re: [PATCH v1 net] sctp: Fix null-ptr-deref in reuseport_add_sock().
Date: Wed, 31 Jul 2024 12:33:18 -0700
Message-ID: <20240731193318.67312-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <8d9989bb-b33c-487a-850a-214f82c59672@yandex.ru>
References: <8d9989bb-b33c-487a-850a-214f82c59672@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC004.ant.amazon.com (10.13.139.203) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Dmitry Antipov <dmantipov@yandex.ru>
Date: Wed, 31 Jul 2024 22:15:12 +0300
> On 7/31/24 10:06 PM, Kuniyuki Iwashima wrote:
> 
> > reuseport_lock is to synchronise operations within the same
> > reuseport group, but which socket should belong to which group
> > is out of scope.
> 
> Hm... then the lock should be a member of 'struct sock_reuseport'
> rather than global, isn't?

I thought that before and it would be doable with more complex
locking since we still need another synchronisation for add/detach
and alloc.  Such operations are most unlikely done concurrently
nor frequently, and the global lock would be enough.

I'll check that again later, but anyway, it's a different topic
for net-next.

