Return-Path: <linux-sctp+bounces-216-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A6E95E2C7
	for <lists+linux-sctp@lfdr.de>; Sun, 25 Aug 2024 10:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09107281DA4
	for <lists+linux-sctp@lfdr.de>; Sun, 25 Aug 2024 08:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1F457CBA;
	Sun, 25 Aug 2024 08:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2QtrOMi"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D983C24;
	Sun, 25 Aug 2024 08:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724576074; cv=none; b=ZCKGQxTGByZwvCmgtxG93xNRMSsMsEYZG0JXn3xwdKRP389eCayNy0ik9AMVJA7yK/b4U1g7YdrLZ3l/yvcfBvvzrre+YXn8+Li89buIGCb3SGAq2jZGqUi/qas5ePb/7R5gehczAYgqTJ0lMObi2f5nuixFFbkKJSrixGJz8Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724576074; c=relaxed/simple;
	bh=WScW3blxv8xyRqcV5XEZlySOdaveuOpeuadU2hXSBvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQqi4A7s/GjuiRZJDjbKwRQWfsRdgQ7RnL/NZ7P2jtLGC3m/rlhFYv2lp6VTyEqH0n+/nKv3TizlYGuRbiwr/OuOJ5zzcvJvyEwZsgnuR0iax9t7XRonq9BflVkJJTTbQBL8XdfzFHkwwkCjdyi4ZRuDHAi+jqL/k+6qzP2VRc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2QtrOMi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FBCC32782;
	Sun, 25 Aug 2024 08:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724576074;
	bh=WScW3blxv8xyRqcV5XEZlySOdaveuOpeuadU2hXSBvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O2QtrOMixcNogYC16XRCkHms8dao2z57r7oaHS1QHdCDymrywWL692s3g+LT05KL2
	 gSLquHvbi2Ohj1nQsVeUKvoX60Fc7MfImlevitZ0RxFZLRWw4YwkwE1NNioagMZti2
	 LdwC9/WKO/FVatTsjtWu3G9h+lDNMPyF93XyNoINYsl5t6jrYBvEGzjiRRuOCfh9Bc
	 sw7xpleWrHQh3xj+PtfsPdQQmgel4BHWPbRL/hEagDddjaHsPw/o4J0cUBN65ujzM8
	 lksaKio008oG5AxbmqeRS3/4v866RYSVV7bnU2yq1kuVfFB0tmpmeopCIvk6TzqveW
	 amJjGfL17C15Q==
Date: Sun, 25 Aug 2024 09:54:26 +0100
From: Simon Horman <horms@kernel.org>
To: Philipp Stanner <stanner@posteo.de>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	David Ahern <dsahern@kernel.org>, Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>,
	Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>,
	Sean Tranchetti <quic_stranche@quicinc.com>,
	Paul Moore <paul@paul-moore.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>, Martin Schiller <ms@dev.tdt.de>,
	netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-sctp@vger.kernel.org,
	linux-x25@vger.kernel.org
Subject: Re: [PATCH net-next 00/13] net: header and core spelling corrections
Message-ID: <20240825085426.GY2164@kernel.org>
References: <20240822-net-spell-v1-0-3a98971ce2d2@kernel.org>
 <d15e45f17dcb9c98664590711ac874302a7e6689.camel@posteo.de>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d15e45f17dcb9c98664590711ac874302a7e6689.camel@posteo.de>

On Sun, Aug 25, 2024 at 07:52:45AM +0000, Philipp Stanner wrote:
> Am Donnerstag, dem 22.08.2024 um 13:57 +0100 schrieb Simon Horman:
> > This patchset addresses a number of spelling errors in comments in
> > Networking files under include/, and files in net/core/. Spelling
> > problems are as flagged by codespell.
> > 
> > It aims to provide patches that can be accepted directly into net-
> > next.
> > And splits patches up based on maintainer boundaries: many things
> > feed directly into net-next. This is a complex process and I
> > apologise
> > for any errors.
> 
> Are you aware that this lessens git blame's ability to provide the
> latest relevant change and associated commit message?
> 
> Many software projects suffer from whitespace and spelling fixes
> preventing git blame from figuring out years later what original code
> was intended to do.
> 
> I'd consider that improving spelling might not win that cost-benefit-
> ratio.

Sure, that is a judgment call that can be made.  I think that it is pretty
common for spelling corrections to be accepted, and I do think there is a
value in having things spelt correctly.  But if the consensus is otherwise,
then fine.

