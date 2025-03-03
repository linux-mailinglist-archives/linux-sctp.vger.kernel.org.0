Return-Path: <linux-sctp+bounces-373-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86174A4CF1E
	for <lists+linux-sctp@lfdr.de>; Tue,  4 Mar 2025 00:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0402E3ABB98
	for <lists+linux-sctp@lfdr.de>; Mon,  3 Mar 2025 23:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C859234989;
	Mon,  3 Mar 2025 23:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="utJ2IsOs"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF78A1537C8;
	Mon,  3 Mar 2025 23:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741043807; cv=none; b=Rw31rjGE0f8vcFK3zrNy7e4cbooyPLYr6pqGKYaAOPZZoj4H1NdadAGGDJONsLIu6nOvxtvCAsXbitroRHg97iLkBB599MWjuZbEwty1JMUb04hNtI0auP/XdFUZKDzVEZsOC5y3DhPSXpI+1J0Uxc+pLn6U68Bi2TVy9MjxL6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741043807; c=relaxed/simple;
	bh=r5La5+5hmAHBPH8HRhX5Op6QDEw96wGl7iEja/R/NQo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iF28voeXDAeZg6U4dZSfeSK+t/VNC1PxfL/zhPa2C6HzRbqu6A2wz7NBY6WCLBw/iPSLLWmLMoU+HTuF1nV05qXy3Ts3wTCc9dHLjNPKxFPrHd2vOBTJrrRdv7vSLpqRe078JxiXVDVfvQHqfb2jBPKZjzwDDrn/lmWqm8NlrNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=utJ2IsOs; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741043804; x=1772579804;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mj1EmNXhvxl4Nn+MCAuDdRx1cIyMTvK9oaD1vpww+gc=;
  b=utJ2IsOscU4Z1/Wg6MPOukeV4Xu9s1gdFOJdI4aYS/JEJhR9RMSaHaXA
   0DN44f2ZqrCYWXj1aZ/mmwunnW0xIPq4i34HpOo/amgRKLmWkGdnp5kPq
   TX9ERNQzKIOPN+rPubtRJyqTJ7dvBwZaLN7qDwHr3YL6W22e5PoDl5cH+
   w=;
X-IronPort-AV: E=Sophos;i="6.13,330,1732579200"; 
   d="scan'208";a="175163777"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 23:16:42 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:18980]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.163:2525] with esmtp (Farcaster)
 id 35e0a8b4-73ce-4e66-8250-9171df3aff74; Mon, 3 Mar 2025 23:16:42 +0000 (UTC)
X-Farcaster-Flow-ID: 35e0a8b4-73ce-4e66-8250-9171df3aff74
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 3 Mar 2025 23:16:42 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 3 Mar 2025 23:16:37 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <geliang@kernel.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-sctp@vger.kernel.org>, <lucien.xin@gmail.com>,
	<marcelo.leitner@gmail.com>, <martineau@kernel.org>, <matttbe@kernel.org>,
	<mptcp@lists.linux.dev>, <ncardwell@google.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <tanggeliang@kylinos.cn>, <willemb@google.com>
Subject: Re: [PATCH net-next v2 1/3] sock: add sock_kmemdup helper
Date: Mon, 3 Mar 2025 15:16:27 -0800
Message-ID: <20250303231627.52523-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <f828077394c7d1f3560123497348b438c875b510.1740735165.git.tanggeliang@kylinos.cn>
References: <f828077394c7d1f3560123497348b438c875b510.1740735165.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Geliang Tang <geliang@kernel.org>
Date: Fri, 28 Feb 2025 18:01:31 +0800
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch adds the sock version of kmemdup() helper, named sock_kmemdup(),
> to duplicate the input "src" memory block using the socket's option memory
> buffer.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

