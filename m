Return-Path: <linux-sctp+bounces-1268-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QXZEJVP7MGoiaAUAu9opvQ
	(envelope-from <linux-sctp+bounces-1268-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 16 Jun 2026 09:29:23 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3130868CDA8
	for <lists+linux-sctp@lfdr.de>; Tue, 16 Jun 2026 09:29:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ksBhxwFw;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1268-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1268-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDDCB312E8AD
	for <lists+linux-sctp@lfdr.de>; Tue, 16 Jun 2026 07:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDA8314D18;
	Tue, 16 Jun 2026 07:24:14 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A96426738B;
	Tue, 16 Jun 2026 07:24:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781594654; cv=none; b=bbq5jEjQfGQFviOcqn27qr2cAA3E/r9f1HhZ+7Y1WPbtylo/u04wpVT8Q1tK+iI0oWYsdhh3NHGXSLNb6AJTAC7akfl4DnvrI092K24MwfjGnE6Pz7qq5d41ds7nsyepJgWz8fOjEfnrhUJBkzO09Z3IE8lLQA311FCNhXSMxyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781594654; c=relaxed/simple;
	bh=mSHCAKPeuTTnzKFb0PvI4Fx6VQ5sLrhRW/y2oKPXMzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igXvbNGD7YA5PmPHrhsyJG9gACYdTwv3KerjOyjelkQ6Ah+bmucdZ/QAWkHhVD+j52C5goKeVkmetKPtb8TvfkFookZfhL++sRh0NL35Y4gaXdjVDS/MqmyljAytlHmk6OBfu4D9ZD1Yp7HUxfFHNwb0ytTIYgpIKGwKGLVisYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksBhxwFw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229611F000E9;
	Tue, 16 Jun 2026 07:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781594653;
	bh=cl6PMnisnJ9/Bdbcjub8BxhQjZ5k0rKJxO4bzTolNjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ksBhxwFwZFgd+37XpML9NW934otgeATdW3p6WiCTD8OPkCwwARFiYIMu683z3jOCG
	 e+KnZt58UC1QIw9M6mX2EC5WlPSnv/H5kk9w3v597m/yl1OpueuWvpdAAGzZyumsNt
	 P1vv6ZmzJZFuiJwo7kwpgGtAPDTWl/V035IktVf8zNZi7bM1ClmrZDof8FIcp8S41a
	 baFltYe+8G0ttu5KyDjd2Lt+cT9NBPpMQqJTse1L83AkGxucNB7ofg5aERZ0F8CXpX
	 QA3kp7RLQcdCJ1Bw5OYKeENO5MsVPzEiylvnrM5V+wrVtol3N3hWhUQ34te9AZG8vH
	 31G0iPRtgUw0A==
Date: Tue, 16 Jun 2026 08:24:08 +0100
From: Simon Horman <horms@kernel.org>
To: Xin Long <lucien.xin@gmail.com>
Cc: netdev@vger.kernel.org, linux-sctp@vger.kernel.org, davem@davemloft.net,
	kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
	marcelo.leitner@gmail.com, w@1wt.eu, zdi-disclosures@trendmicro.com
Subject: Re: [PATCH net] sctp: hold socket lock when dumping endpoints in
 sctp_diag
Message-ID: <20260616072408.GR712698@horms.kernel.org>
References: <1bbd999cf88fb1ea93f4a3743047bce9b51adc24.1781287178.git.lucien.xin@gmail.com>
 <20260615110402.753443-2-horms@kernel.org>
 <CADvbK_e062WLNVy+BbuNTNoJGBvQBR7PHp_BmxLwwSGq4O9_dw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvbK_e062WLNVy+BbuNTNoJGBvQBR7PHp_BmxLwwSGq4O9_dw@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1268-lists,linux-sctp=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,gmail.com,1wt.eu,trendmicro.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:lucien.xin@gmail.com,m:netdev@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:marcelo.leitner@gmail.com,m:w@1wt.eu,m:zdi-disclosures@trendmicro.com,m:lucienxin@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,linux-sctp@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-sctp@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,horms.kernel.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3130868CDA8

On Mon, Jun 15, 2026 at 02:24:34PM -0400, Xin Long wrote:
> On Mon, Jun 15, 2026 at 7:04 AM Simon Horman <horms@kernel.org> wrote:
> >
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > Full review at: https://netdev-ai.bots.linux.dev/sashiko/

...

> Low: #1, #2, #5, not really issues,
> but worth mentioning about it in changelog.
> 
> Critical: #3, not valid.
> socket refcnt can't be 0 when traversing the chain under read_lock_bh().
> 
> But it seems better to hold ep instead sk, and also to check
> ep->base.dead instead of sk_state CLOSED.
> 
> Medium: #4, not valid.
> it's completely okay to dump duplicate or skip socks because of
> concurrent close() and listen() in diag.
> 
> will post v2 with some improvements mentioned above.

Thanks, much appreciated.

