Return-Path: <linux-sctp+bounces-608-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBDDB287FA
	for <lists+linux-sctp@lfdr.de>; Fri, 15 Aug 2025 23:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F79E5680FC
	for <lists+linux-sctp@lfdr.de>; Fri, 15 Aug 2025 21:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51BB223DC0;
	Fri, 15 Aug 2025 21:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeHz71c0"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B6C1A2C06;
	Fri, 15 Aug 2025 21:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755294611; cv=none; b=EulcGICJ+J0tSsQit6etRxkw+5IziJkdFJC8jpkxLPBIPgI0EScf7EwDflGCHBo7CjAwGsyYWNDsXgqrlk3uhC2f7GlI+DapDRaPBJ/J34rJt6OHW1EiviIrzjtGhMlhZGp9nJhIk9CESds88u0AW3eICE8U8FKbSJ27sczPoao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755294611; c=relaxed/simple;
	bh=MxgkB66MUbddmAZhB9tANtPcCjoYOpNJFxoJqvb8KsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1kZd3rToTugm2SOTu1RKibyGlBzUGu7dVF4HfmPlyf48l/m286CRjNxXzbmWEsF3NtMfuW7JLRVMW6mZyWUYIB99kgbhapYkBNgXROlMhsi/thtNaRpidvQv1tm/NtOSFUvEf6HXOfer9xjis4fIXcBT3TPWWFMo0WdiaCfzuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KeHz71c0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18AFC4CEEB;
	Fri, 15 Aug 2025 21:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755294611;
	bh=MxgkB66MUbddmAZhB9tANtPcCjoYOpNJFxoJqvb8KsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KeHz71c04cPgRHQfuu1aVBXIztU6bwzm+Fa5dQOddp6To4PPHyLtWG+WM5x98+6Zl
	 XmOOHpbwNUnmKA2RxbVUksz+SOTTScrVmOO7HIRW3FJKTEVbLmDgXy2Jp1hj4+2kdV
	 A1e6GEGhpEJrj49QQ5JktJBdynPGP4mx+1IzhSGwSfwkzOJAVF/HE5kdJFi2w7MdCG
	 9he5n1i5sjgYH+M/914r6PTlHrT1nlwn47K28j3aNbn75Ec2Z6vu/EFqXh0ZOgXpMq
	 fiPXyASFqZ1wCcHyG6jGBbgmVXOXn/3QNh72wHl84PfV3lFAbqEoUVedt57kjzLSK8
	 ne4IrwkUqdpXg==
Date: Fri, 15 Aug 2025 14:50:09 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Xin Long <lucien.xin@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] sctp: Convert cookie authentication to
 use HMAC-SHA256
Message-ID: <20250815215009.GA2041@quark>
References: <20250813040121.90609-1-ebiggers@kernel.org>
 <20250813040121.90609-4-ebiggers@kernel.org>
 <20250815120910.1b65fbd6@kernel.org>
 <CADvbK_csEoZhA9vnGnYbfV90omFqZ6dX+V3eVmWP7qCOqWDAKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvbK_csEoZhA9vnGnYbfV90omFqZ6dX+V3eVmWP7qCOqWDAKw@mail.gmail.com>

On Fri, Aug 15, 2025 at 05:19:27PM -0400, Xin Long wrote:
> On Fri, Aug 15, 2025 at 3:09 PM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Tue, 12 Aug 2025 21:01:21 -0700 Eric Biggers wrote:
> > > +     if (net->sctp.cookie_auth_enable)
> > > +             tbl.data = (char *)"sha256";
> > > +     else
> > > +             tbl.data = (char *)"none";
> > > +     tbl.maxlen = strlen(tbl.data);
> > > +     return proc_dostring(&tbl, 0, buffer, lenp, ppos);
> >
> > I wonder if someone out there expects to read back what they wrote,
> > but let us find out.
> I feel it's a bit weird to have:
> 
> # sysctl net.sctp.cookie_hmac_alg="md5"
> net.sctp.cookie_hmac_alg = md5
> # sysctl net.sctp.cookie_hmac_alg
> net.sctp.cookie_hmac_alg = sha256
> 
> This patch deprecates md5 and sha1 use there.
> So generally, for situations like this, should we also issue a
> warning, or just fail it?
> 
> Paolo, what do you think?
> 
> >
> > It'd be great to get an ack / review from SCTP maintainers, otherwise
> > we'll apply by Monday..
> Other than that, LGTM.
> Sorry for the late reply, I was running some SCTP-auth related tests
> against the patchset.

Ideally we'd just fail the write and remove the last mentions of md5 and
sha1 from the code.  But I'm concerned there could be a case where
userspace is enabling cookie authentication by setting
cookie_hmac_alg=md5 or cookie_hmac_alg=sha1, and by just failing the
write the system would end up with cookie authentication not enabled.

It would have been nice if this sysctl had just been a boolean toggle.

A deprecation warning might be a good idea.  How about the following on
top of this patch:

diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index 19acc57c3ed97..72af4a843ae52 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -399,20 +399,28 @@ static int proc_sctp_do_hmac_alg(const struct ctl_table *ctl, int write,
 		tbl.data = tmp;
 		tbl.maxlen = sizeof(tmp) - 1;
 		ret = proc_dostring(&tbl, 1, buffer, lenp, ppos);
 		if (ret)
 			return ret;
-		if (!strcmp(tmp, "sha256") ||
-		    /* for backwards compatibility */
-		    !strcmp(tmp, "md5") || !strcmp(tmp, "sha1")) {
+		if (!strcmp(tmp, "sha256")) {
 			net->sctp.cookie_auth_enable = 1;
 			return 0;
 		}
 		if (!strcmp(tmp, "none")) {
 			net->sctp.cookie_auth_enable = 0;
 			return 0;
 		}
+		/*
+		 * Accept md5 and sha1 for backwards compatibility, but treat
+		 * them simply as requests to enable cookie authentication.
+		 */
+		if (!strcmp(tmp, "md5") || !strcmp(tmp, "sha1")) {
+			pr_warn_once("net.sctp.cookie_hmac_alg=%s is deprecated. Use net.sctp.cookie_hmac_alg=sha256\n",
+				     tmp);
+			net->sctp.cookie_auth_enable = 1;
+			return 0;
+		}
 		return -EINVAL;
 	}
 	if (net->sctp.cookie_auth_enable)
 		tbl.data = (char *)"sha256";
 	else

