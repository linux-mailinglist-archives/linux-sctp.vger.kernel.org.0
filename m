Return-Path: <linux-sctp+bounces-374-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEB6A4CF29
	for <lists+linux-sctp@lfdr.de>; Tue,  4 Mar 2025 00:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C769F7A8BC5
	for <lists+linux-sctp@lfdr.de>; Mon,  3 Mar 2025 23:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F52523A99B;
	Mon,  3 Mar 2025 23:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="WS8+px+D"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A89234989;
	Mon,  3 Mar 2025 23:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741043933; cv=none; b=qDlVTGNBOiSsMIOQ9LXAg7lobeQCJnF1FCmr3AeY19RMDywmafet8apoEutObKqvYf5+ymKYBukfK7/jIdgfRvzuY5ITuf2C+ec1CU72+BMOnJ86sCgv7cMq8cYPZohMR9xRa6jgN/RXq/z4nyJ6L1NZITL61wKQHFZ2+SwT720=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741043933; c=relaxed/simple;
	bh=75Jn9qPKR9d4M5XUHZWVnIp4CRugtiPUgEN8/jui51w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g5PjYqrNZrz6zAleIcOnlnYHtvEwOrdPAgoV0o37W5wYKStuy6P98D7IQ8K3u7t1maRHmstRkPI6nwSj2HeeZcVO3eEAwn6JjOkNg/JKgo/ZcsaXKGe2ybqQNbS0cvX0JWWiYDKWgFvfnbm9SDNyGHKyUXnPqogRcM8HlxdkE2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=WS8+px+D; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741043932; x=1772579932;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZViLdi3ojvhopE+8J4/4sLSnVbqqECFJhUc7P+79Qm8=;
  b=WS8+px+D/08qzRWWh5mkaI3qqEVx+19M+zc4ZXqiVD8AH4TdO3gP4JV8
   jMAoFziTs7lCJbdkZU0TIRYXx5k82TzfY8tmi7HxjFIjcBAlcDfHoUv0k
   x96E44Err2acYITVyWUfK+jpdu+NKNS37x+231NbX5XhbIa3atdz/aJWg
   U=;
X-IronPort-AV: E=Sophos;i="6.13,330,1732579200"; 
   d="scan'208";a="723533064"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 23:18:47 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:11853]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.53.36:2525] with esmtp (Farcaster)
 id 9dc24e04-fcd1-4781-a873-5ffe0a27c734; Mon, 3 Mar 2025 23:18:46 +0000 (UTC)
X-Farcaster-Flow-ID: 9dc24e04-fcd1-4781-a873-5ffe0a27c734
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 3 Mar 2025 23:18:46 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 3 Mar 2025 23:18:38 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <geliang@kernel.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-sctp@vger.kernel.org>, <lucien.xin@gmail.com>,
	<marcelo.leitner@gmail.com>, <martineau@kernel.org>, <matttbe@kernel.org>,
	<mptcp@lists.linux.dev>, <ncardwell@google.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <tanggeliang@kylinos.cn>, <willemb@google.com>
Subject: Re: [PATCH net-next v2 2/3] net: use sock_kmemdup for ip_options
Date: Mon, 3 Mar 2025 15:18:26 -0800
Message-ID: <20250303231826.52654-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <91ae749d66600ec6fb679e0e518fda6acb5c3e6f.1740735165.git.tanggeliang@kylinos.cn>
References: <91ae749d66600ec6fb679e0e518fda6acb5c3e6f.1740735165.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA001.ant.amazon.com (10.13.139.124) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Geliang Tang <geliang@kernel.org>
Date: Fri, 28 Feb 2025 18:01:32 +0800
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Instead of using sock_kmalloc() to allocate an ip_options and then
> immediately duplicate another ip_options to the newly allocated one in
> ipv6_dup_options(), mptcp_copy_ip_options() and sctp_v4_copy_ip_options(),
> the newly added sock_kmemdup() helper can be used to simplify the code.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

