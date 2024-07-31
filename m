Return-Path: <linux-sctp+bounces-188-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC976943606
	for <lists+linux-sctp@lfdr.de>; Wed, 31 Jul 2024 21:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59BF61F22AA7
	for <lists+linux-sctp@lfdr.de>; Wed, 31 Jul 2024 19:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953B83308A;
	Wed, 31 Jul 2024 19:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CRsc8PLG"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6168BE0;
	Wed, 31 Jul 2024 19:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722452807; cv=none; b=UbKNaQjVDFjBtDSgS6iz8g0y92IkX1KG9ELHZVek0/7ZmCOfSGF0RTM1ea5Mcxn14bEwecKDCUlu6bP4vVAGTXWTVIVkuKxCV437nb6RH5gzAdVL0N77RCFkwjMtq1F9BRIjVHKUSfZwdwlpTt/kznN/H3O8tyIbYggsP9aq+BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722452807; c=relaxed/simple;
	bh=ZC6tUznYLlGlwYfvbvcBmksZyx2Jvs8kvmIQYnfdbXM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mnOfI0p2oyjYhWfcLCr1vC8NQqY/dY/P/IowbJ0sFN0GgryR9rlDyyRcfLXKFXm0uAAVvQ3m3xBuBqhTXqkhJz3w0WXSAQ2OtTKg5/nXvlTmPou3AVaPNmR4mrUX8EabIZLWigHnWfkNWy3Pfm7Csxpe5WhwkBxg/3XbYZym1YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=CRsc8PLG; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722452806; x=1753988806;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dOhssezJry2Ifn/TnaGT0aSBqTxAahr+XqgFI9LXxws=;
  b=CRsc8PLGQCzTTvcakd0EmrXKNC3XR8sTtDKlKrNDD+quVbl1Z24ucTqe
   UwzS4Nql762BAO1r3iSHwJAEpR4HK0djltEMPs8Z3yj7fPXRnriHMMkM9
   VcRVqwjJbk+92f4PzCsrSGRTL3ofwa0pfI6jFZL7fxIPFI47w4/6TaHbT
   Q=;
X-IronPort-AV: E=Sophos;i="6.09,251,1716249600"; 
   d="scan'208";a="649885631"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 19:06:42 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:60554]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.84:2525] with esmtp (Farcaster)
 id b08c83fc-e3d6-42d3-83f2-1f43b323d1c9; Wed, 31 Jul 2024 19:06:41 +0000 (UTC)
X-Farcaster-Flow-ID: b08c83fc-e3d6-42d3-83f2-1f43b323d1c9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 31 Jul 2024 19:06:37 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 31 Jul 2024 19:06:34 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <dmantipov@yandex.ru>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <linux-sctp@vger.kernel.org>,
	<lucien.xin@gmail.com>, <marcelo.leitner@gmail.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzbot+e6979a5d2f10ecb700e4@syzkaller.appspotmail.com>
Subject: Re: Re: [PATCH v1 net] sctp: Fix null-ptr-deref in reuseport_add_sock().
Date: Wed, 31 Jul 2024 12:06:25 -0700
Message-ID: <20240731190625.58651-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240731070537.303533-1-dmantipov@yandex.ru>
References: <20240731070537.303533-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA004.ant.amazon.com (10.13.139.16) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Dmitry Antipov <dmantipov@yandex.ru>
Date: Wed, 31 Jul 2024 10:05:37 +0300
> > What happens if two sockets matching each other reach here ?
> 
> Not sure.

If two sockets reach the reuseport_alloc() path, two identical
reuseport groups are created.

Then, in __sctp_rcv_lookup_endpoint(), incoming packets hit only
one socket group placed before the other in the hash bucket, and
the other socket no longer receive data and silently died from
userspace POV.

The suggested change papers over the problem.

reusport_add_sock() and reuseport_alloc() must be placed in the
same writer critical section.


> In general, an attempt to use rather external thing (struct
> sctp_hashbucket) to implement extra synchronization for reuse innards
> looks somewhat weird.

reuseport_lock is to synchronise operations within the same
reuseport group, but which socket should belong to which group
is out of scope.

That must be well-defined and synchronised at the upper level.

I'll post v2 with updated changelog.

Thanks!

