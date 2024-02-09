Return-Path: <linux-sctp+bounces-15-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 096A284F30B
	for <lists+linux-sctp@lfdr.de>; Fri,  9 Feb 2024 11:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D4C3B26EB7
	for <lists+linux-sctp@lfdr.de>; Fri,  9 Feb 2024 10:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D2367E64;
	Fri,  9 Feb 2024 10:15:51 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail.fink.org (mail.fink.org [79.134.252.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8F0664C3
	for <linux-sctp@vger.kernel.org>; Fri,  9 Feb 2024 10:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.134.252.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707473750; cv=none; b=u71nvfuLW7/aJMczlK8HALsZCN3D8Uxubc8+KlkjHZvf5rUCQRSZcdi8OYPEUbGH9Jn1lxpekTRyvMEjRqrckHYwTZkdEVv+uW8Blf0cXth2QkKrHq+wH4xJA1WP3mtK0GqL8XiXShrfdt1KY9/PONsATTme2NAjqew03N6Kfpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707473750; c=relaxed/simple;
	bh=Mwcjxih1EGyPimqjI58QuglK2wa7l6KITZHqPzfWUew=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=kxxSKx5xGW5Oeum060AEtWgael+HBtlcRiDe91nUZ9I4jcnLAapUuhvfQoUsRPoGF8366i04FTOYHIdojEP0YZHQItjqm9y34Tm82CYiECCUOGpCcw0+LqL4u+Ic2/u9W6fngAh17Mqddf5Ito7oFzCXTP2gusoe5ENbtoIareQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=list.fink.org; spf=none smtp.mailfrom=list.fink.org; arc=none smtp.client-ip=79.134.252.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=list.fink.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=list.fink.org
X-Footer: Zmluay5vcmc=
Received: from smtpclient.apple ([79.134.238.11])
	(authenticated user list@fink.org)
	by mail.fink.org (Kerio Connect 10.0.4) with ESMTPSA
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
	Fri, 9 Feb 2024 11:10:32 +0100
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: Linux SCTP multihoming question
From: Andreas Fink <afink@list.fink.org>
In-Reply-To: <1024792113.114715673.1707473146836.JavaMail.zimbra@free.fr>
Date: Fri, 9 Feb 2024 11:10:22 +0100
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 linux-sctp <linux-sctp@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6709B96C-917E-4E70-9DD6-D555534F791F@list.fink.org>
References: <6f6f11b5c30bce3d6e77d719ef75112dee75250d.profile@marceloleitner.u.sourceforge.net>
 <YsbiDrG1PQ2Gng5T@t14s.localdomain>
 <1937458162.418765580.1657717120765.JavaMail.zimbra@free.fr>
 <1024792113.114715673.1707473146836.JavaMail.zimbra@free.fr>
To: o.evistel@free.fr
X-Mailer: Apple Mail (2.3774.400.31)

yes this is possible. My eSTP does this exactly this way. for M3UA and =
M2PA You simply use sctp_bindx to bind to exact local address you need.
You can add or remove local IP's and alter the association. But I'm not =
sure if you can force a specific path to be used as primary. SCTP =
basically can use any and switch over to the other.

If you think of something like hot/standby setup, you might want to do =
this on M3UA level which means having two SCTP associations (two ASPs in =
one AS)



> On 9 Feb 2024, at 11:05, o.evistel@free.fr wrote:
>=20
>=20
> Dear Marcelo
>=20
> I am using linux-sctp as transport for SIGTRAN M3UA on RHEL 8.4 with =
multihoming (sctp_bindx(), sctp_connectx() API functions).
> I would like to know, after association setup, if it is possible to =
instruct SCTP to use a specific local address from the list of bound =
addresses to reach the peer.
>=20
> Regards
> Omar AIT AMRANE
>=20



